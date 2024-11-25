

Here is the updated README with the added information:


Task 5: Simple Application Deployment with Helm
==============================================

## Project Setup
---------------

To get started with this project, you need to set up the environment and dependencies as described below.

### Clone the Repository

```bash
git clone https://github.com/askhat-zab/rsschool-devops-course-tasks.git --branch task_5
```

### Change into the Project Directory

```bash
cd tasks/task_5
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

## Wordpress Installation
----------------------

After Terraform output, login to the EC2 public instance.

### Check Helm Version

Verify that Helm is installed and running.

```bash
helm version
```

### Add Helm Repository

Add the Helm repository for the Wordpress chart.

```bash
helm repo add askhat-zab https://askhat-zab.github.io/repo/helm/charts
```

### List Helm Repositories

Verify that the Helm repository was added successfully.

```bash
helm repo list
```

### Install Wordpress

Install the Wordpress amd Mysql chart using Helm.

```bash
helm upgrade --install task-5-mysql  askhat-zab/task-5-mysql
helm upgrade --install task-5-wordpress  askhat-zab/task-5-wordpress
```

### Check Wordpress installation

Check the Wordpress amd Mysql chart using Helm.

```bash
helm ls
kubectl get pods
```

### Configure Proxy

Install a proxy server (example nginx) on the public EC2 instance and add a proxy pass to the Wordpress deployment.

```
apt install nginx -y
```


### Add SSL Certificate (Optional)

Add an SSL certificate to proxy server if desired.

examaple nginx config

```
# ------------------------------------------------------------
# wordpress.itcorp.uk
# ------------------------------------------------------------

server {
  set $forward_scheme http;
  set $server         <your-ip>;
  set $port           <your-service-port>;
  listen 80;

  listen 443 ssl http2;
  server_name wordpress.itcorp.uk;
  # Let's Encrypt SSL
  include conf.d/include/letsencrypt-acme-challenge.conf;
  include conf.d/include/ssl-ciphers.conf;
  ssl_certificate /etc/letsencrypt/live/npm-1/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/npm-1/privkey.pem;
}

```

## Additional Resources
--------------------

* [Helm documentation](https://helm.sh/docs/)
* [Wordpress documentation](https://wordpress.org/support/)
* [Terraform documentation](https://www.terraform.io/docs/)
