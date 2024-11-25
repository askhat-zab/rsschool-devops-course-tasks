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

# ## Test k3s cluster
# resource "null_resource" "kubectl-from-work-pc" {
#   depends_on = [module.ec2_public, module.ec2_private, null_resource.ssh-keys]
#   ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
#   provisioner "local-exec" {
#     command = <<EOF
#       sleep 240
#       rm -rf .kube
#       mkdir -p .kube
#       sudo scp -i ~/.ssh/id_ed25519 -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@${aws_eip.bastion_eip.public_ip}:~/.kube/config .kube/config
#       ssh -D 8080 -q -N ubuntu@${aws_eip.bastion_eip.public_ip} &
#       sleep 5
#       export HTTPS_PROXY=socks5://127.0.0.1:8080
#       export KUBECONFIG=".kube/config"
#       sudo chown -R  $(whoami): .kube
#       kubectl get nodes
#       kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
#       sleep 60
#       kubectl get pods
#       unset HTTPS_PROXY
#     EOF
#   }
# }

# # Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
