# connect s3 backend created in previous bootstrap step
terraform {
  backend "s3" {
    bucket = "askhat-zab-tf-state"
    key    = "course-admin/terraform.tfstate"
    region = "eu-central-1"
  }
}
