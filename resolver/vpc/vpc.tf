module "vpc" {
  source  = "aws-ia/vpc/aws"
  version = "4.4.1"

  name       = "vpc-dev-public"
  cidr_block = "10.248.0.0/16"
  az_count   = 1

  # vpc_ipv4_ipam_pool_id   = var.vpc_ipv4_ipam_pool_id
  # vpc_ipv4_netmask_length = 20

  # transit_gateway_id = aws_ec2_transit_gateway.this.id
  # transit_gateway_routes = {
  #   public              = "10.212.0.0/16"
  #   # private             = aws_ec2_managed_prefix_list.core_network.id
  # }

  subnets = {
    public = {
      name_prefix               = "dev-public"
      netmask                   = 24
      nat_gateway_configuration = "all_azs"
      tags = {
        subnet_type = "public"
      }
    }
    endpoints = {
      name_prefix = "dev-endpoints"
      netmask     = 24
      tags = {
        subnet_type = "endpoints"
      }
    }
    private = {
      # omitting name_prefix defaults value to "private"
      # name_prefix  = "private_with_egress"
      netmask                 = 24
      connect_to_public_natgw = true
    }
  }

  tags = {
    env = "core-network"
  }
}