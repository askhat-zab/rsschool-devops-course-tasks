

# Bootstrap Account
=====================================

## Create Access Key for Root
-----------------------------

1. Go to IAM -> Users -> `<YOUR-ROOT-USER>`
2. In the "Security credentials" tab, create a new access key for the root user
3. Also, assign an MFA device to solve

### AWS Config File

Create a `~/.aws/config` file with the following content:
```markdown
[profile ROOT]
region = your-preferred-region

[profile ADMIN]
region = your-preferred-region
```

Create a `~/.aws/credentials` file with the following content:
```markdown
[ROOT]
aws_access_key_id=your-root-access-key-id
aws_secret_access_key=your-root-secret-access-key
[ADMIN]
aws_access_key_id=your-access-key-id
aws_secret_access_key=your-secret-access-key
```

Or Export your AWS access key ID and secret access key:
```bash
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
export AWS_DEFAULT_REGION=your-preferred-region
```


### Create IAM User and S3 bucket

In this module, we create an admin IAM user with a new pair of Access Key ID and Secret Access Key, as well as an S3 bucket for root and admin user executions tf-state files.

### Initialize Terraform

1. Go to the `tasks/bootstrap` directory
2. Execute the following commands:
```bash
terraform init
terraform plan -var "aws_profile=ROOT"
terraform apply --auto-approve -var "aws_profile=ROOT"
```

Note: Replace the placeholders with your actual values.

### Init Root TF-State File in S3 Backend

1. Uncomment `backend.tf` and execute `terraform init`
2. You will see the following prompt:
```
Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes
```
3. Enter `yes` to copy the existing state to the new backend
4. Terraform will be successfully initialized, and you can begin working with it

Note: You may need to run `terraform plan` to see any changes required for your infrastructure. All Terraform commands should now work. If you ever set or change modules or backend configuration for Terraform, rerun this command to reinitialize your working directory. If you forget, other commands will detect it and remind you to do so if necessary.


## Disable Access Key for Root
-----------------------------

1. Go to IAM -> Users -> `<YOUR-ROOT-USER>`
2. Delete a previous created access key for the root user