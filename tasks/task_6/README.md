

Here is the updated README with the added information:


Task 6: Application Deployment via Jenkins Pipeline
==============================================

## Project Setup
---------------

To get started with this project, you need to set up the environment and dependencies as described below.

### Clone the Repository

```bash
git clone https://github.com/askhat-zab/rsschool-devops-course-tasks.git --branch task_6
```

### Change into the Project Directory

```bash
cd tasks/task_6
```

### Initialize Terraform

```bash
terraform init
```

### Plan the Terraform Configuration

```bash
terraform plan
```

### Apply the Terraform Configuration

```bash
terraform apply
```

## Jenkins Installation
----------------------

After Terraform output, login to the EC2 public instance.

### Check Helm Version

Verify that Helm is installed and running.

```bash
helm version
```

### Add Helm Repository

Add the Helm repository for the Jenkins chart.

```bash
helm repo add jenkins https://charts.jenkins.io
```

### Update Helm Repositories

Verify that the Helm repository was added successfully.

```bash
helm repo update
```

### Install Jenkins

Install the Jenkins amd Mysql chart using Helm.

```bash
helm upgrade --install jenkins jenkins/jenkins --namespace jenkins --create-namespace
```

### Check Jenkins installation

Check the Jenkins amd Mysql chart using Helm.

```bash
helm ls --namespace jenkins 
kubectl get pods --namespace jenkins 
```

### Configure Proxy

Install a proxy server (example nginx) on the public EC2 instance and add a proxy pass to the Jenkins deployment.

```
apt install nginx -y
```


### Add SSL Certificate (Optional)

Add an SSL certificate to proxy server if desired.

examaple nginx config

```
# ------------------------------------------------------------
# Jenkins.itcorp.uk
# ------------------------------------------------------------

server {
  set $forward_scheme http;
  set $server         <your-ip>;
  set $port           <your-service-port>;
  listen 80;

  listen 443 ssl http2;
  server_name Jenkins.itcorp.uk;
  # Let's Encrypt SSL
  include conf.d/include/letsencrypt-acme-challenge.conf;
  include conf.d/include/ssl-ciphers.conf;
  ssl_certificate /etc/letsencrypt/live/npm-1/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/npm-1/privkey.pem;
}

```

## Some additional commands

### Check Jenkins password

```
kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```

### Create secret for ECR
```
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 897722688515.dkr.ecr.eu-central-1.amazonaws.com
kubectl create secret generic ecr-secret --namespace=jenkins --from-file=.dockerconfigjson=$HOME/.docker/config.json --dry-run=client -o json | kubectl apply -f -
```



## Additional Resources
--------------------

* [Helm documentation](https://helm.sh/docs/)
* [Jenkins documentation](https://Jenkins.org/support/)
* [Terraform documentation](https://www.terraform.io/docs/)
