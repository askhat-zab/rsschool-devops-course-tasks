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
