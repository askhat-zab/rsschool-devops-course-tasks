# connect terraform providers
terraform {
  required_version = ">=1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.69.0"
    }
  }
}

# create aws provider uncomment for local execute
provider "aws" {
  access_key = var.access_key_id
  secret_key = var.secret_access_key
  region     = var.aws_region
  # shared_config_files      = var.aws_config_path
  # shared_credentials_files = var.aws_creds_path
  # region                   = var.aws_region
  # profile                  = var.aws_profile
}

