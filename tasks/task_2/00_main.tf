# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# AWS Key Pair to be associated with EC2 Instance
resource "aws_key_pair" "terraform" {
  key_name = var.instance_keypair
  # public_key = file("~/.ssh/id_ed25519.pub")
  public_key = file(var.public_key_location)
}

# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public, module.vpc]
  tags       = { Name = "EIP-${var.env_prefix}" }
  instance   = module.ec2_public.id
  domain     = "vpc"
}
