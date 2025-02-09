variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets_cidrs" {
  description = "Public subnets mapping"
  type        = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "private_subnets_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
