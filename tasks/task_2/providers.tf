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
  # shared_config_files      = var.aws_config_path
  # shared_credentials_files = var.aws_creds_path
  # region                   = var.aws_region
  # profile                  = var.aws_profile
}

