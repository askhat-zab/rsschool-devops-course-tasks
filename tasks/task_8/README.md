

Here is the updated README with the added information:


Task 8: Grafana Installation and Dashboard Creation
==============================================

## Project Setup
---------------

To get started with this project, you need to set up the environment and dependencies as described below.

### Clone the Repository

```bash
git clone https://github.com/askhat-zab/rsschool-devops-course-tasks.git --branch task_8
```

### Change into the Project Directory

```bash
cd tasks/task_8
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

## Monitoring Installation
----------------------

After Terraform output, login to the EC2 public instance.

### Check Helm Version

Verify that Helm is installed and running.

```bash
helm version
```

### Add Helm Repository

Add the Helm repository for the bitnami chart.

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

### Update Helm Repositories

Verify that the Helm repository was added successfully.

```bash
helm repo update
```

### Install kube-state-metrics

Install the KSM chart using Helm.

```bash
helm upgrade --install kube-state-metrics bitnami/kube-state-metrics \
              --namespace monitoring \
              --create-namespace  \
              --atomic 
```

### Install Prometheus

Install the Prometheus chart using Helm.

```bash
helm upgrade --install prometheus bitnami/prometheu \
              --namespace monitoring \
              --create-namespace  \
              --atomic \
              -f prometheus-values.yaml
```


### Install Grafana

Install the Grafana chart using Helm.

```bash
helm upgrade --install grafana bitnami/prometheu \
              --namespace monitoring \
              --create-namespace  \
              --atomic \
              -f grafana-values.yaml
```



### Check monitoring installation

Check using Helm.

```bash
helm ls --namespace monitoring 
kubectl get pods --namespace monitoring 
```

### Connect via web interface

Check your public IP

```bash
curl ifconfig.me
```

Than execute command and connect via browser for check applications

```bash
kubectl -n monitoring  port-forward --address 0.0.0.0 services/prometheus-server 9090:80
```
Connect to <your-public-IP>:9090 to prometheus


```bash
kubectl -n monitoring  port-forward --address 0.0.0.0 services/kube-state-metrics 8080:8080
```
Connect to <your-public-IP>:8080 to kube-state-metrics


```bash
kubectl -n monitoring  port-forward --address 0.0.0.0 services/grafana 3000:3000 &
```

Get the user credentials:
```bash
echo "User: admin"
echo "Password: $(kubectl get secret grafana-secret --namespace monitoring -o jsonpath="{.data.password}" | base64 -d)"
```
Connect to <your-public-IP>:3000 to grafana


After work disable port-forward commands

## Additional Resources
--------------------

* [Helm documentation](https://helm.sh/docs/)
* [Terraform documentation](https://www.terraform.io/docs/)
* [Helm Chart for Prometheus](https://github.com/bitnami/charts/tree/main/bitnami/prometheus)
* [Helm Chart for kube-state-metrics](https://github.com/bitnami/charts/tree/main/bitnami/kube-state-metrics)
* [Helm Chart for Grafana](https://github.com/bitnami/charts/tree/main/bitnami/grafana)

