#!/bin/bash

# Removes apt locks. This is useful when apt is stuck in an
# undefined state, such as when it is waiting for a response
# from a dialog box.
remove_apt_locks() {
    sudo killall apt apt-get
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock*
}


# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install git python3 python3-pip -y
sudo apt remove ansible -y
sudo python3 -m pip install --upgrade pip
sudo pip3 install ansible
export PATH=$PATH:/usr/local/bin

# Clone the k3s-ansible repository
git clone https://github.com/k3s-io/k3s-ansible.git
cd k3s-ansible 

# Run the Ansible playbook with retry logic
max_retries=5
retry_count=0

while [ $retry_count -lt $max_retries ]; do
    # ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbooks/site.yml -i /tmp/inventory.yml --extra-vars "ansible_user=ubuntu" --private-key /tmp/id_ed25519
    ansible-playbook playbooks/site.yml -i /tmp/inventory.yml

    if [ $? -eq 0 ]; then
        echo "Ansible playbook executed successfully"
        break
    else
        echo "Ansible playbook failed. Attempting to remove locks and retry..."
        remove_apt_locks
        retry_count=$((retry_count+1))
        sleep 60
    fi
done

if [ $retry_count -eq $max_retries ]; then
    echo "Failed to execute Ansible playbook after $max_retries attempts"
    exit 1
fi

# Install yq
sudo wget https://github.com/mikefarah/yq/releases/download/v4.30.8/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq

# Copy kubeconfig from master node to bastion and modify it
MASTER_IP=$(yq e '.k3s_cluster.children.server.hosts | keys | .[0]' /tmp/inventory.yml)
mkdir -p /home/ubuntu/.kube
sudo scp -i /tmp/id_ed25519 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  ubuntu@$MASTER_IP:/home/ubuntu/.kube/config /home/ubuntu/.kube/config

# Replace localhost/127.0.0.1 with the actual master IP in the kubeconfig
sudo sed -i "s/127.0.0.1/$MASTER_IP/g" /home/ubuntu/.kube/config
sudo chown -R  ubuntu: /home/ubuntu/.kube

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Install Docker Engine
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# # Set kubectl context and check nodes
# # echo $KUBECONFIG
# sudo kubectl config use-context default
# sudo kubectl get nodes

source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "alias k=kubectl"  >> ~/.bashrc 
echo "complete -o default -F __start_kubectl k"  >> ~/.bashrc 
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
