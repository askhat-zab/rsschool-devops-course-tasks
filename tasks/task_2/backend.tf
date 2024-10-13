# connect s3 backend created in previous bootstrap step
terraform {
  backend "s3" {
    bucket = "askhat-zab-tf-state"
    key    = "task-2/terraform.tfstate"
    region = "eu-central-1"
  }
}
