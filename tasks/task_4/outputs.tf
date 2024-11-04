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

# Private EC2 Instances
## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]
}


# ## Curl Test for Bastion Host
# resource "null_resource" "check_via_curl" {
#   depends_on = [module.ec2_public]
#   ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
#   provisioner "local-exec" {
#     # command = "curl -s http://${aws_eip.bastion_eip.public_ip}:8080"
#     command = "curl -s http://${aws_eip.bastion_eip.public_ip}:8080/api/"
#   }
# }


# ## Remote Exec Provisioner: remote-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
# resource "null_resource" "check_in_bastion_comnand" {
#   depends_on = [module.ec2_public]
#   connection {
#     host        = aws_eip.bastion_eip.public_ip
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("~/.ssh/id_ed25519")
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "kubectl get nodes"
#     ]
#   }
# }


# │ Error: remote-exec provisioner error
# │ 
# │   with null_resource.check_in_bastion_comnand,
# │   on outputs.tf line 45, in resource "null_resource" "check_in_bastion_comnand":
# │   45:   provisioner "remote-exec" {
# │ 
# │ error executing "/tmp/terraform_326432935.sh": Process exited with status 127


