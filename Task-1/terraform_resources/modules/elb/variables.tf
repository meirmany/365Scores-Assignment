variable "security_groups" {
  description = "List of Security Group IDs for ELB"
  type        = list(string)
}

variable "subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

