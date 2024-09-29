# Connect an IAM user module
module "iam-user" {
  source         = "../../modules/iam-user"
  aws_admin_user = var.aws_admin_user
  env_prefix     = var.env_prefix
}

# Connect S3 bucket module for Terraform state
module "s3-tf-state" {
  source      = "../../modules/s3-tf-state"
  bucket_name = var.bucket_name
  env_prefix  = var.env_prefix
}
