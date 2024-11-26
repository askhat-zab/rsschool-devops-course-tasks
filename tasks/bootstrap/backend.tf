# # this is terraform backend for root user  for bootstraping
# # uncomment content below after bootstraping s3 bucket
# terraform {
#   backend "s3" {
#     bucket = "askhat-zab-tf-state"
#     key    = "root/terraform.tfstate"
#     region = "eu-central-1"
#   }
# }
