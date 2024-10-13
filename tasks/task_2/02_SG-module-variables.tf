# variables.tf

variable "sg_ingress_rules" {
  description = "List of ingress rules for the security group"
  type        = list(string)
  default     = ["ssh-tcp", "http-80-tcp", "http-8080-tcp", "https-443-tcp"]
}

variable "sg_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_rules" {
  description = "List of egress rules for the security group"
  type        = list(string)
  default     = ["all-all"]
}
