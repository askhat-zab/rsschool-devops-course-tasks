# variable "aws_config_path" {}
# variable "aws_creds_path" {}
# variable "aws_profile" {}
# variable "aws_region" {}


variable "env_prefix" {
  type    = string
  default = "task-7"
}

# Path to Public Key
variable "public_key_location" {
  description = "Public Key Path"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

# variable "access_key_id" {
#   description = "AWS Access Key"
#   type        = string
# }

# variable "secret_access_key" {
#   description = "AWS Secret Access Key"
#   type        = string
# }


