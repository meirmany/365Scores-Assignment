terraform {
  required_version = ">= 1.10.5"
  #required_version = ">= 1.1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}
