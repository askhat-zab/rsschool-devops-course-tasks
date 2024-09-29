# variables for bootstrap
variable "aws_profile" {}
variable "aws_region" {}
variable "aws_admin_user" {}
variable "env_prefix" {}
variable "bucket_name" {}
variable "aws_config_path" {
  type = list(string)
}
variable "aws_creds_path" {
  type = list(string)
}
