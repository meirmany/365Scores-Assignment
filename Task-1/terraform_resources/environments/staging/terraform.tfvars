environment = "staging"
vpc_cidr  = "10.1.0.0/16"

public_subnets_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
azs                 = ["us-east-1a", "us-east-1b"]

domain_name = "staging.365scores.com"
