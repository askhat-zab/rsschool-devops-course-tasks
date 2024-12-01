# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  depends_on = [module.ec2_private]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.6.0"
  name       = "${var.env_prefix}-bastion"
  # ami                         = data.aws_ami.amzlinux2.id
  ami                         = data.aws_ami.ubuntu_22_04.id
  instance_type               = var.instance_type_public
  key_name                    = var.instance_keypair
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.public_bastion_sg.security_group_id]
  tags                        = { Name = "${var.env_prefix}-bastion" }
  associate_public_ip_address = true

  user_data = file("entry-script.sh")
}



