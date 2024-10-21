
### public


# AWS EC2 Instance Type Public
variable "instance_type_public" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}


### private

# AWS EC2 Instance Type Private
variable "instance_type_private" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}


### both public and private

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "laptop_ key"
}
