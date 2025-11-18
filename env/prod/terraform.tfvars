# -----------------------------------------
# REQUIRED VALUES 
# -----------------------------------------

# Product Context Variables
product_name              = "foodpro"
product_name_short        = "foodpro"
product_environment       = "production"
product_environment_short = "prod"
product_asset_id          = 9329
product_context           = "level4"
product_criticality       = "Important"
product_data_class        = "level4"
product_hosted_by         = "DevOps-APT4"

shared_values_prefix = "SharedValues-campussvcs-prod"

acm_certificate_arn       = "arn:aws:acm:us-east-1:726016721108:certificate/38309679-57fe-4e8f-810e-ad35d8abce45"
iam_instance_profile_name = "campussvcs-prod-foodpro-instance-role"
jail_sg                   = true
lift_and_shift            = true

create_alb = false

alb_sg_ingress_rules = {
  "elb_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow HTTP from Internal"
  },
  "elb_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow HTTPS from Internal"
  },
}
alb_sg_egress_rules = {
  "all" = {
    from_port   = null
    to_port     = null
    ip_protocol = "-1"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow All out"
  }
}

gsas_web_ingress_rules = {
  "all_gsas_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.202.0/24"
    description = "Allow All from GSAS VPN"
  },
  "all_adsysadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.208.0/24"
    description = "Allow All from AD Sysadmin VPN"
  },
  "socdbadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow All from SOC DB Admin VPN"
  },


}

gsas_web_egress_rules = {
  "all_gsas_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.202.0/24"
    description = "Allow All from GSAS VPN"
  },
  "all_adsysadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.208.0/24"
    description = "Allow All from AD Sysadmin VPN"
  },
  "socdbadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow All from SOC DB Admin VPN"
  },
}

gsas_sql_ingress_rules = {
  "all_gsas_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.202.0/24"
    description = "Allow All from GSAS VPN"
  },
  "all_adsysadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.208.0/24"
    description = "Allow All from AD Sysadmin VPN"
  },
  "socdbadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow All from SOC DB Admin VPN"
  },
  "mssql2" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.137.198.107/32"
    description = "Allow MSSQL from infra.prod.diprod.huit.harvard.edu"
  },
  "mssql3" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.143.21.96/32"
    description = "Allow MSSQL from GSAS PF Terminal server"
  },
  "mssql4" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.145.149.0/24"
    description = "Allow MSSQL from OCI Network"
  },
  "mssql5" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.137.198.0/24"
    description = "Allow MSSQL from OCI Network"
  },
  "mssql6" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.137.199.0/24"
    description = "Allow MSSQL from OCI Network"
  },
  "mssql7" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.137.200.0/24"
    description = "Allow MSSQL from OCI Network"
  },
  "mssql8" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.138.214.0/24"
    description = "Allow MSSQL from IDMC app vpc"
  },
  "mssql9" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.138.215.0/24"
    description = "Allow MSSQL from IDMC app vpc"
  },
  "mssql10" = {
    from_port   = 1433
    to_port     = 1433
    ip_protocol = "tcp"
    cidr_ipv4   = "10.138.216.0/24"
    description = "Allow MSSQL from IDMC app vpc"
  },
  "mssql11" = {
    from_port                    = 1433
    to_port                      = 1433
    ip_protocol                  = "tcp"
    referenced_security_group_id = "sg-0869eff2fcff289a8"
    description                  = "Allow MSSQL from GSAS PROD TS"
  },
  "smb1" = {
    from_port   = 445
    to_port     = 445
    ip_protocol = "tcp"
    cidr_ipv4   = "10.137.104.0/21"
    description = "Allow SMB from FAS prod"
  },
  "smb2" = {
    from_port   = 445
    to_port     = 445
    ip_protocol = "tcp"
    cidr_ipv4   = "10.139.144.0/23"
    description = "Allow SMB from FAS prod"
  },
  "smb3" = {
    from_port   = 445
    to_port     = 445
    ip_protocol = "tcp"
    cidr_ipv4   = "10.143.20.0/22"
    description = "Allow SMB from FAS prod"
  },
  "smb5" = {
    from_port   = 445
    to_port     = 445
    ip_protocol = "tcp"
    cidr_ipv4   = "10.140.134.0/23"
    description = "Allow SMB from fas-dev-standard-vpc CIDRS"
  },
  "smb6" = {
    from_port   = 445
    to_port     = 445
    ip_protocol = "tcp"
    cidr_ipv4   = "10.143.140.0/22"
    description = "Allow SMB from fas-dev-standard-vpc CIDRS"
  },
}

gsas_sql_egress_rules = {
  "all_gsas_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.202.0/24"
    description = "Allow All from GSAS VPN"
  },
  "all_adsysadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.208.0/24"
    description = "Allow All from AD Sysadmin VPN"
  },
  "socdbadmin_vpn" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow All from SOC DB Admin VPN"
  },
}

gsas_web_instances = {
  0 = {
    name          = "gsas-financialaidweb-prod"
    ami_id        = "ami-0bd829e4f30dc38b0"
    instance_type = "m5.xlarge"
    key_name      = "powerfaids-gsas-prod-standard"
    static        = true
    platform      = "windows"
    backup_policy = "11PM_DAILY"
    patch_policy  = "Week1"
    jail_sg       = false
    create        = true
    domain_name   = "gsas-pf-web.fas.cloud.huit.harvard.edu"
    root_block_device = [
      {
        volume_type = "gp2"
        volume_size = 100
      },
    ]
  }
}
