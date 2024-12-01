# connect s3 backend
terraform {
  backend "s3" {
    bucket = "askhat-zab-tf-state"
    key    = "task-7/terraform.tfstate"
    region = "eu-central-1"
  }
}
