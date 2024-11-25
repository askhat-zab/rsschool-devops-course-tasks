# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.env_prefix}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  depends_on             = [module.vpc]
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.6.0"
  name                   = "${var.env_prefix}-vm-${each.key}"
  ami                    = data.aws_ami.ubuntu_22_04.id
  instance_type          = var.instance_type_private
  key_name               = var.instance_keypair
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
  tags                   = { Name = "${var.env_prefix}-vm-${each.key}" }
  for_each               = toset(["0", "1"])

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt upgrade -y
              sudo apt install python3 python3-pip awscli -y
              EOF
}
