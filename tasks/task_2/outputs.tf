# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

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

## Curl Test for Bastion Host
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "curl -s http://${aws_eip.bastion_eip.public_ip}:8080"
  }
}
