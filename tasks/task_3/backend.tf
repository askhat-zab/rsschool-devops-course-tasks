# connect s3 backend
terraform {
  backend "s3" {
    bucket = "askhat-zab-tf-state"
    key    = "task-3/terraform.tfstate"
    region = "eu-central-1"
  }
}
