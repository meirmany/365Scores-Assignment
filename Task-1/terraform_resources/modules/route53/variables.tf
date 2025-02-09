variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "elb_dns" {  # Ensure this variable exists
  description = "DNS name of the ELB"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

