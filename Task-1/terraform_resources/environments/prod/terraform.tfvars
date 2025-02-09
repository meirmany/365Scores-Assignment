environment = "prod"
vpc_cidr  = "10.2.0.0/16"

public_subnets_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets_cidrs = ["10.2.3.0/24", "10.2.4.0/24"]
azs                 = ["us-east-1a", "us-east-1b"]

domain_name = "365scores.com"
