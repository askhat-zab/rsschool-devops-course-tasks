# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "course-vpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_azs" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}


# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets

# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  type    = bool
  default = true
}

# VPC NAT Gateway Configuration
variable "vpc_single_nat_gateway" {
  type    = bool
  default = false
}

# VPC NAT Gateway Configuration
variable "vpc_one_nat_gateway_per_az" {
  type    = bool
  default = false
}

