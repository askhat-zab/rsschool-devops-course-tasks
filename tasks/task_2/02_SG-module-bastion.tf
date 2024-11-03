# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks

  ingress_rules = var.sg_ingress_rules

  ingress_cidr_blocks = var.sg_ingress_cidr_blocks
  # Egress Rule - all-all open
  egress_rules = var.sg_egress_rules
  tags         = { Name = "SG-${var.env_prefix}" }
}

