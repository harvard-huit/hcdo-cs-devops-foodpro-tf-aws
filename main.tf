# ------------------------------------------------------------------------------
# Locals
# ------------------------------------------------------------------------------

locals {

  # Retrieve the default tags and region from the constants module
  default_tags   = module.constants.default_tags
  default_region = module.constants.default_region

  # Retrieve the whole VCN Config and OCID from the metadata module
  vpc_config = module.metadata.vpc_config
  vpc_id     = module.metadata.vpc_config.vpc_id

  # Retrieve the AZ Count and Global SGs from the metadata module
  az_count         = module.metadata.vpc_config.az_count
  global_sg_all    = module.metadata.vpc_config.global_sg_all
  global_sg_lm_web = module.metadata.vpc_config.global_sg_lm_web

  # NOTE: The below subnet calls are meant as examples -- please feel free to use whichever method works best for your use case and delete the ones you don't need.

  # Retrieve standard subnets directly from the metadata module
  standard_app_subnet     = module.metadata.vpc_config.subnets.standard.app
  standard_db_subnet      = module.metadata.vpc_config.subnets.standard.db
  standard_elbpriv_subnet = module.metadata.vpc_config.subnets.standard.elbpriv
  standard_elbpub_subnet  = module.metadata.vpc_config.subnets.standard.elbpub

  # Retrieve the level4 subnets directly from the metadata module
  level4_app_subnet     = module.metadata.vpc_config.subnets.level4.app
  level4_db_subnet      = module.metadata.vpc_config.subnets.level4.db
  level4_elbpriv_subnet = module.metadata.vpc_config.subnets.level4.elbpriv
  level4_elbpub_subnet  = module.metadata.vpc_config.subnets.level4.elbpub

  # Retrieve the Subnet IDs more dynamically from the metadata module using the product context variable.
  elbpub_subnet  = module.metadata.vpc_config.subnets["${var.product_context}"].elbpub
  elbpriv_subnet = module.metadata.vpc_config.subnets["${var.product_context}"].elbpriv
  app_subnet     = module.metadata.vpc_config.subnets["${var.product_context}"].app
  db_subnet      = module.metadata.vpc_config.subnets["${var.product_context}"].db

  # Retrieve the Subnet ID of a single tier by use of the tier variable. This is useful if you want to create multiple resources in the same tier.
  tier_subnet = module.metadata.vpc_config.subnets["${var.product_context}"]["${var.tier}"]

  # You can additionally make the subnet calls more dynamic by using a 'app tier' variable

  # subnet = module.metadata.vpc_config.subnets["${var.product_context}"]["${var.app_tier}"]

  # If you have additional global tags you'd like to add to all resources, you can do that like this:
  # global_tags = merge(
  #   local.default_tags,
  #   {
  #     "some_tag_key"              = "some_tag_value",
  #   }
  # )
  # You can then use the same merge function to add these tags to any resource you create alongside any resource-specific tags.

  encryption_properties = {
    encrypted  = true
    kms_key_id = module.foodpro_ec2_key.key_arn
  }

  alb_ingress_to_web_rules = {
    "elb_http" = {
      from_port                    = 80
      to_port                      = 80
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.foodpro_private_alb_sg.sg.id
      description                  = "Allow HTTP from ALB"
    },
    "elb_https" = {
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.foodpro_private_alb_sg.sg.id
      description                  = "Allow HTTPS from ALB"
    },
  }

  alb_egress_from_web_rules = {
    "elb_http" = {
      from_port                    = 80
      to_port                      = 80
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.foodpro_private_alb_sg.sg.id
      description                  = "Allow HTTP to ALB"
    },
    "elb_https" = {
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.foodpro_private_alb_sg.sg.id
      description                  = "Allow HTTPS to ALB"
    },
  }

}

# ------------------------------------------------------------------------------
# Data Sources
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Modules
# ------------------------------------------------------------------------------

module "constants" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_constants/aws"
  version = "~> v1.0"

  # Product Context Variables
  product_name              = var.product_name
  product_name_short        = var.product_name_short
  product_environment       = var.product_environment
  product_environment_short = var.product_environment_short
  product_asset_id          = var.product_asset_id
  product_context           = var.product_context
  product_criticality       = var.product_criticality
  product_data_class        = var.product_data_class
}

module "metadata" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_metadata/aws"
  version = "~> v2.0"

  # Set to the defual shared valued in CF Export
  shared_values_prefix = var.shared_values_prefix

}

# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

module "foodpro_private_alb_sg" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_sg/aws"
  version = "~> v2.0"


  # Module Variables
  tier   = "app"
  vpc_id = module.metadata.vpc_config.vpc_id

  name_prefix = "${module.constants.resource_prefix}-web-alb-priv"

  ingress_rules = var.alb_sg_ingress_rules

  egress_rules = var.alb_sg_egress_rules

}

module "foodpro_instance_ec2_sg" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_sg/aws"
  version = "~> v2.0"


  # Module Variables
  tier   = "app"
  vpc_id = module.metadata.vpc_config.vpc_id

  name_prefix = "${module.constants.resource_prefix}-web-ec2"

  ingress_rules = merge(var.foodpro_instance_ingress_rules, local.alb_ingress_to_web_rules)

  egress_rules = merge(var.foodpro_instance_egress_rules, local.alb_egress_from_web_rules)

  jailed     = var.jail_sg
  depends_on = [module.foodpro_private_alb_sg]
}

# -----------------------------------------------------------------------------
# Application Load Balancer
# -----------------------------------------------------------------------------

locals {
  log_bucket_name = "campussvcs-${var.product_environment_short}-standard-elb-logs"
}

module "foodpro_private_alb_record" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_route53/aws"
  version = "~> v0.1"

  count = var.create_alb ? 1 : 0

  zone_id     = var.zone_id
  domain_name = var.foodpro_private_alb_domain_name
  type        = "A"
  alias = {
    name                   = module.foodpro_private_alb[0].dns_name
    evaluate_target_health = false
  }
}

module "foodpro_private_alb" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_loadbalancer/aws"
  version = "~> v0.0" # This is just to ensure the latest version will be pulled when the app is first set up.

  count = var.create_alb ? 1 : 0

  internal       = true
  constants_data = module.constants
  metadata_data  = module.metadata

  security_group_ids = [module.foodpro_private_alb_sg.sg.id]
  subnet_ids         = module.metadata.vpc_config.subnets[var.product_context]["elbpriv"]

  enable_deletion_protection = true

  access_logs = {
    bucket = local.log_bucket_name
    prefix = "${var.product_name_short}/${var.product_environment_short}/access-logs"
  }

  connection_logs = {
    bucket  = local.log_bucket_name
    enabled = true
    prefix  = "${var.product_name_short}/${var.product_environment_short}/connection-logs"
  }

  client_keep_alive = 7200

  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = var.acm_certificate_arn

      forward = {
        target_group_key = "foodpro_web_priv_tg"
      }
    }
  }

  target_groups = {
    foodpro_web_priv_tg = {
      name                              = "${module.constants.resource_prefix}-alb-https-priv-tg"
      protocol                          = "HTTPS"
      port                              = 443
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      create_attachment                 = true
      target_id                         = module.foodpro_instance[0].id

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTPS"
        matcher             = "200-399"
      }


    }
  }
  tags = merge(
    local.default_tags,
    {
      Name         = "${module.constants.resource_prefix}-alb"
      map-migrated = "PE-EHJNICEHK0"
    },
  )
}

# -----------------------------------------------------------------------------
# Instances
# -----------------------------------------------------------------------------

module "foodpro_ec2_key" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_kms/aws"
  version = "~> v0.2"

  tags = merge(local.default_tags, {
    hosted_by = var.product_hosted_by
  })
  description    = "KMS key for ${var.product_name_short}-${var.product_environment_short} resources."
  constants_data = module.constants
  kms_key_for    = "ec2"
  tier           = "app"
  iam_role_name  = var.iam_instance_profile_name
  lift_and_shift = var.lift_and_shift
}

module "foodpro_instance_record" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_route53/aws"
  version = "~> v0.1"

  for_each = { for k, v in var.foodpro_instances : k => v if v.create }

  zone_id     = var.zone_id
  domain_name = each.value.domain_name
  type        = "A"
  ttl         = 300
  records     = [module.foodpro_instance[each.key].private_ip]
}

module "foodpro_instance" {
  source  = "artifactory.huit.harvard.edu/cloudarch-terraform-virtual__aws-modules/aws_ec2/aws"
  version = "~> v2.0"

  for_each = { for k, v in var.foodpro_instances : k => v if v.create }

  name          = each.value.name
  static        = each.value.static
  platform      = each.value.platform
  backup_policy = each.value.backup_policy
  instance_type = each.value.instance_type
  # subnet_id     = each.value.subnet_id != null ? each.value.subnet_id : module.metadata.vpc_config.subnets[var.product_context]["app"][each.key % module.metadata.az_count]

  jailed = each.value.jail_sg

  constants_data = module.constants
  metadata_data  = module.metadata

  root_block_device = each.value.root_block_device != null ? [for device in each.value.root_block_device : merge(device, local.encryption_properties)] : null

  modify_existing_ebs_block_devices = each.value.modify_existing_ebs_block_devices != null ? { for k, v in each.value.modify_existing_ebs_block_devices : k => merge(v, local.encryption_properties) } : null

  ami = each.value.ami_id
  # security_group_ids      = [module.foodpro_instance_ec2_sg.sg.id]
  disable_api_stop        = true
  disable_api_termination = true
  key_name                = each.value.key_name

  iam_instance_profile_name = var.iam_instance_profile_name

  tags = merge(
    local.default_tags,
    {
      patch_policy = each.value.patch_policy
      hosted_by    = var.product_hosted_by
      environment  = var.product_environment
      map-migrated = "PE-EHJNICEHK0"
    }
  )
}

resource "aws_network_interface" "foodpro_db_static" {

  for_each = { for k, v in var.foodpro_instances : k => v if v.create }

  subnet_id       = each.value.subnet_id != null ? each.value.subnet_id : module.metadata.vpc_config.subnets[var.product_context]["app"][each.key % module.metadata.az_count]
  security_groups = var.jail_sg ? [module.foodpro_instance_ec2_sg.sg.id] : [module.metadata.global_sg_all, module.foodpro_instance_ec2_sg.sg.id]

  tags = merge(
    local.default_tags,
    {
      Name         = "${each.value.name}-nic"
      map-migrated = "PE-EHJNICEHK0"
      hosted_by    = var.product_hosted_by
      environment  = var.product_environment
    }
  )

}
