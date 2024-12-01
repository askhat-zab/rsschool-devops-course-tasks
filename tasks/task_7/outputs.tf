# AWS EC2 Instance Terraform Outputs

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "EC2 instance ID"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "Elastic IP address EC2 instance"
  value       = aws_eip.bastion_eip.public_ip

}

# Private EC2 Instances
## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]
}

## bastion_user
output "bastion_user" {
  description = "Username to SSH as"
  value       = "ubuntu"
}


# Region Output
output "aws_region" {
  description = "AWS region of the ECR repository"
  value       = var.aws_region
}

# Authentication Instruction Output
output "ecr_login_instructions" {
  description = "Command to authenticate Docker with the ECR registry"
  value       = "Run the following command to authenticate Docker with the ECR repository: aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin $(aws ecr describe-repositories --repository-names ${aws_ecr_repository.admin_ecr_repo.name} --region ${var.aws_region} --query 'repositories[0].repositoryUri' --output text)"
}


# aws ecr get-login-password --region eu-central-1
# docker login --username AWS --password-stdin 897722688515.dkr.ecr.eu-central-1.amazonaws.com
