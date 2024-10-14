# Terraform module which creates VPC resources on AWS.
# This module is inspired by a popular repository: https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  # VPC Basic Details
  name            = var.vpc_name
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  # One NAT Gateway per subnet (default behavior)
  # NAT Gateways - Outbound Communication
  enable_nat_gateway     = var.vpc_enable_nat_gateway     # true
  single_nat_gateway     = var.vpc_single_nat_gateway     # false
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az # false

  # Should be true to adopt and manage Default Network ACL	
  manage_default_network_acl = true
  # Whether to use dedicated network ACL (not default) and custom rules for public subnets	
  public_dedicated_network_acl = true
  public_inbound_acl_rules     = concat(local.vpc_network_acls["default_inbound"], local.vpc_network_acls["public_inbound"])
  public_outbound_acl_rules    = concat(local.vpc_network_acls["default_outbound"], local.vpc_network_acls["public_outbound"])
  # Whether to use dedicated network ACL (not default) and custom rules for private subnets	
  private_dedicated_network_acl = true
  private_inbound_acl_rules     = concat(local.vpc_network_acls["default_inbound"], local.vpc_network_acls["private_inbound"])
  private_outbound_acl_rules    = concat(local.vpc_network_acls["default_outbound"], local.vpc_network_acls["private_outbound"])

  # Indicates whether to create a separate route table for each public subnet. Default: false	
  create_multiple_public_route_tables = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Additional Tags to Subnets
  public_subnet_tags = {
    Name = "Public Subnets ${var.env_prefix}"
  }
  private_subnet_tags = {
    Name = "Private Subnets ${var.env_prefix}",
  }

  # Additional Tags to Subnets
  public_route_table_tags = {
    Name = "Public RTB ${var.env_prefix}"
  }
  private_route_table_tags = {
    Name = "Private RTB ${var.env_prefix}",
  }

  nat_gateway_tags = {
    Name = "NAT GW per subnet${var.env_prefix}",
  }

  tags     = { Name = var.env_prefix }
  vpc_tags = { Name = "VPC-${var.env_prefix}" }
}

