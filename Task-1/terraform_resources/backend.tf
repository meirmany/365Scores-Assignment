#terraform {
#  backend "s3" {
#    bucket  = "my-terraform-state-bucket" # Replace with your bucket name
#    key     = "envs/${terraform.workspace}/terraform.tfstate"
#    region  = "us-east-1"
#    encrypt = true
#  }
#}
