variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}
