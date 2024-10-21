# variables for bootstrap
variable "aws_profile" {
  default = "ROOT"
}
variable "aws_region" {}
variable "aws_admin_user" {}
variable "env_prefix" {
  default = "bootstrap"
}
variable "bucket_name" {
  default = "askhat-zab-tf-state"
}
variable "aws_config_path" {}
variable "aws_creds_path" {}
