# Create a Null Resource and Provisioners
resource "null_resource" "ssh-keys" {
  depends_on = [module.ec2_public, module.ec2_private]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_eip.bastion_eip.public_ip
    # user        = "ec2-user"
    user        = "ubuntu"
    password    = ""
    private_key = file("~/.ssh/id_ed25519")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "~/.ssh/id_ed25519"
    destination = "/tmp/id_ed25519"
  }

  provisioner "file" {
    source      = "inventory.yml"
    destination = "/tmp/inventory.yml"
  }
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/id_ed25519",
      "sed -i 's/SERVER_IP/${module.ec2_private["0"].private_ip}/g' /tmp/inventory.yml",
      "sed -i 's/AGENT_IP/${module.ec2_private["1"].private_ip}/g' /tmp/inventory.yml",
      "cat /tmp/inventory.yml" # This will print the inventory file contents for verification
    ]
  }
}
