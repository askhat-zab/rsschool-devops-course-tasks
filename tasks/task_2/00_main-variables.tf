# variable "aws_config_path" {}
# variable "aws_creds_path" {}
# variable "aws_profile" {}
# variable "aws_region" {}


variable "env_prefix" {
  type    = string
  default = "task-2"
}

# Path to Public Key
variable "public_key_location" {
  description = "Public Key Path"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
