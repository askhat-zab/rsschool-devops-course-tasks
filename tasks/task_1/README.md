# Task 1

## MFA User configured (10 points)

Provide a screenshot of the non-root account secured by MFA (ensure sensitive information is not shared).

* [Admin User MFA](images/admin_user_MFA.png)
* [Root User MFA](images/root_user_MFA.png)

## Bucket and GithubActionsRole IAM role configured (30 points)

Terraform code is created and includes:

* A bucket for Terraform states
* IAM role with correct Identity-based and Trust policies

* Bucket created in previous bootstrap step and used different key
* To create GithubActionsRole and trust policy, execute commands in dir tasks/task_1:
  * `terraform init`
  * `terraform plan`
  * `terraform apply --auto-approve`

## Github Actions workflow is created (30 points)

Workflow includes all jobs

* Created pipeline in this file .github/workflows/release.yaml

## Code Organization (10 points)

Variables are defined in a separate variables file.
Resources are separated into different files for better organization.

* variables.tf located in different folders

## Verification (10 points)

Terraform plan is executed successfully for GithubActionsRole
Terraform plan is executed successfully for a terraform state bucket

## Additional Tasks (10 points)

Documentation (5 points)
Document the infrastructure setup and usage in a README file.

* Update this README file to include instructions on how to install and set up the project.
* Include information on how to configure the project.
* Add contact information for users who have questions or issues.