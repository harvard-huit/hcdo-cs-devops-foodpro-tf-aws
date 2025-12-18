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

acm_certificate_arn       = "arn:aws:acm:us-east-1:269988613319:certificate/b2b457c2-7572-4d56-b717-ed380e39970e"
iam_instance_profile_name = "campussvcs-prod-foodpro-instance-role"
jail_sg                   = true
lift_and_shift            = true

create_alb = true

# alb_sg_ingress_rules = {
#   "elb_http1" = {
#     from_port   = 80
#     to_port     = 80
#     ip_protocol = "tcp"
#     cidr_ipv4   = "0.0.0.0/0"
#     description = "Allow HTTP from Internal"
#   },
#   "elb_https1" = {
#     from_port   = 443
#     to_port     = 443
#     ip_protocol = "tcp"
#     cidr_ipv4   = "0.0.0.0/0"
#     description = "Allow HTTPS from Internal"
#   },
# }
# alb_sg_egress_rules = {
#   "all" = {
#     from_port   = null
#     to_port     = null
#     ip_protocol = "-1"
#     cidr_ipv4   = "0.0.0.0/0"
#     description = "Allow All out"
#   }
# }

alb_sg_ingress_rules = {
  "cstl_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow HTTP from CSTL VPN NAT"
  },
  "cstl_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow HTTPS from CSTL VPN NAT"
  },
  "cloudadmin_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.22.0/24"
    description = "Allow HTTP from CloudAdmin VPN NAT"
  },
  "cloudadmin_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.22.0/24"
    description = "Allow HTTPS from CloudAdmin VPN NAT"
  },
  "socdbadmin_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow HTTP from SOC DB Admin VPN NAT"
  },
  "socdbadmin_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow HTTPS from SOC DB Admin VPN NAT"
  },
}
alb_sg_egress_rules = {
  "cstl_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow HTTP from CSTL VPN NAT"
  },
  "cstl_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow HTTPS from CSTL VPN NAT"
  },
  "cloudadmin_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.22.0/24"
    description = "Allow HTTP from CloudAdmin VPN NAT"
  },
  "cloudadmin_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.22.0/24"
    description = "Allow HTTPS from CloudAdmin VPN NAT"
  },
  "socdbadmin_vpn_http1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow HTTP from SOC DB Admin VPN NAT"
  },
  "socdbadmin_vpn_https1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.134.0/24"
    description = "Allow HTTPS from SOC DB Admin VPN NAT"
  },
}

foodpro_instance_ingress_rules = {
  "all_traffic1" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow All 1"
  },
  "all_traffic2" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.73.0/24"
    description = "Allow All 2"
  },
  "tcp_8992_1" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.30.0/24"
    description = "Allow TCP 8992 1"
  },
  "tcp_8992_2" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.10.192/26"
    description = "Allow TCP 8992 2"
  },
  "tcp_8992_3" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.3.0/28"
    description = "Allow TCP 8992 3"
  },
  "tcp_8992_4" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow TCP 8992 4"
  },
  "tcp_8992_5" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow TCP 8992 5"
  },
  "tcp_8992_6" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow TCP 8992 6"
  },
  "tcp_8992_7" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow TCP 8992 7"
  },
  "tcp_8992_8" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow TCP 8992 8 "
  },
  "tcp_8992_9" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow TCP 8992 9"
  },
  "tcp_31438_1" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.30.0/24"
    description = "Allow TCP 31438 1"
  },
  "tcp_31438_2" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.10.192/26"
    description = "Allow TCP 31438 2"
  },
  "tcp_31438_3" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.3.0/28"
    description = "Allow TCP 31438 3"
  },
  "tcp_31438_4" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow TCP 31438 4"
  },
  "tcp_31438_5" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow TCP 31438 5"
  },
  "tcp_31438_6" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow TCP 31438 6"
  },
  "tcp_31438_7" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow TCP 31438 7"
  },
  "tcp_31438_8" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow TCP 31438 8"
  },
  "tcp_31438_9" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow TCP 31438 9"
  },
  "tcp_554_1" = {
    from_port   = 554
    to_port     = 554
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 554 1"
  },
  "tcp_8554_1" = {
    from_port   = 8554
    to_port     = 8554
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 8554 1"
  },
  "tcp_7070_1" = {
    from_port   = 7070
    to_port     = 7070
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 7070 1"
  },
  "tcp_7071_1" = {
    from_port   = 7071
    to_port     = 7071
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 7071 1"
  },
  "udp_554_1" = {
    from_port   = 554
    to_port     = 554
    ip_protocol = "udp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow UDP 554 1"
  },
  "http_1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow HTTP 80 1"
  },
  "http_2" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow HTTP 80 2"
  },
  "http_3" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow HTTP 80 3"
  },
  "http_4" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow HTTP 80 4"
  },
  "http_5" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow HTTP 80 5"
  },
  "http_6" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow HTTP 80 6"
  },
  "https_1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow HTTPS 443 1"
  },
  "https_2" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow HTTPS 443 2"
  },
  "https_3" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow HTTPS 443 3"
  },
  "https_4" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow HTTPS 443 4"
  },
  "https_5" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow HTTPS 443 5"
  },
  "https_6" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow HTTPS 443 6"
  },
  "rdp_1" = {
    from_port   = 3389
    to_port     = 3389
    ip_protocol = "tcp"
    cidr_ipv4   = "10.142.34.64/26"
    description = "Allow RDP 3389 1"
  },
}

foodpro_instance_egress_rules = {
  "all_traffic1" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.188.0/24"
    description = "Allow All 1"
  },
  "all_traffic2" = {
    from_port   = null
    to_port     = null
    ip_protocol = -1
    cidr_ipv4   = "10.1.73.0/24"
    description = "Allow All 2"
  },
  "tcp_8992_1" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.30.0/24"
    description = "Allow TCP 8992 1"
  },
  "tcp_8992_2" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.10.192/26"
    description = "Allow TCP 8992 2"
  },
  "tcp_8992_3" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.3.0/28"
    description = "Allow TCP 8992 3"
  },
  "tcp_8992_4" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow TCP 8992 4"
  },
  "tcp_8992_5" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow TCP 8992 5"
  },
  "tcp_8992_6" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow TCP 8992 6"
  },
  "tcp_8992_7" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow TCP 8992 7"
  },
  "tcp_8992_8" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow TCP 8992 8 "
  },
  "tcp_8992_9" = {
    from_port   = 8992
    to_port     = 8992
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow TCP 8992 9"
  },
  "tcp_31438_1" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.11.30.0/24"
    description = "Allow TCP 31438 1"
  },
  "tcp_31438_2" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.10.192/26"
    description = "Allow TCP 31438 2"
  },
  "tcp_31438_3" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "10.248.3.0/28"
    description = "Allow TCP 31438 3"
  },
  "tcp_31438_4" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow TCP 31438 4"
  },
  "tcp_31438_5" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow TCP 31438 5"
  },
  "tcp_31438_6" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow TCP 31438 6"
  },
  "tcp_31438_7" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow TCP 31438 7"
  },
  "tcp_31438_8" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow TCP 31438 8"
  },
  "tcp_31438_9" = {
    from_port   = 31438
    to_port     = 31438
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow TCP 31438 9"
  },
  "tcp_554_1" = {
    from_port   = 554
    to_port     = 554
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 554 1"
  },
  "tcp_8554_1" = {
    from_port   = 8554
    to_port     = 8554
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 8554 1"
  },
  "tcp_7070_1" = {
    from_port   = 7070
    to_port     = 7070
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 7070 1"
  },
  "tcp_7071_1" = {
    from_port   = 7071
    to_port     = 7071
    ip_protocol = "tcp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow TCP 7071 1"
  },
  "udp_554_1" = {
    from_port   = 554
    to_port     = 554
    ip_protocol = "udp"
    cidr_ipv4   = "10.39.133.0/24"
    description = "Allow UDP 554 1"
  },
  "http_1" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow HTTP 80 1"
  },
  "http_2" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow HTTP 80 2"
  },
  "http_3" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow HTTP 80 3"
  },
  "http_4" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow HTTP 80 4"
  },
  "http_5" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow HTTP 80 5"
  },
  "http_6" = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow HTTP 80 6"
  },
  "https_1" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.132.0/24"
    description = "Allow HTTPS 443 1"
  },
  "https_2" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.133.0/24"
    description = "Allow HTTPS 443 2"
  },
  "https_3" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.134.0/24"
    description = "Allow HTTPS 443 3"
  },
  "https_4" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.161.0/25"
    description = "Allow HTTPS 443 4"
  },
  "https_5" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.244.0/24"
    description = "Allow HTTPS 443 5"
  },
  "https_6" = {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "128.103.32.0/27"
    description = "Allow HTTPS 443 6"
  },
  "rdp_1" = {
    from_port   = 3389
    to_port     = 3389
    ip_protocol = "tcp"
    cidr_ipv4   = "10.142.34.64/26"
    description = "Allow RDP 3389 1"
  },
}

foodpro_instances = {
  0 = {
    name          = "dsfooddb-preprod"
    ami_id        = "ami-0a69756aba806579b"
    instance_type = "m5.xlarge"
    key_name      = "foodpro-prod-standard"
    static        = true
    platform      = "windows"
    backup_policy = "11PM_DAILY"
    patch_policy  = "Week1"
    jail_sg       = true
    create        = true
    domain_name   = "dsfooddb-instance-preprod.prod.campusservices.cloud.huit.harvard.edu"
    root_block_device = [
      {
        volume_type = "gp3"
        volume_size = 100
      },
    ]
    modify_existing_ebs_block_devices = {
      01 = {
        device_name = "/dev/sdb"
        volume_type = "gp3"
        volume_size = 200
      }
    }
  }
}

zone_id                         = "Z3TAOW6NH6G64H"
foodpro_private_alb_domain_name = "dsfooddb-preprod.prod.campusservices.cloud.huit.harvard.edu"
