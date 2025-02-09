provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = var.vpc_cidr
  environment = terraform.workspace
}

module "subnets" {
  source      = "./modules/subnets"
  vpc_id      = module.vpc.vpc_id
  environment = terraform.workspace

  azs                   = var.azs
  private_subnets_cidrs = var.private_subnets_cidrs

  public_subnets_cidrs = [
    for az, cidr in zipmap(var.azs, var.public_subnets_cidrs) :
    {
      availability_zone = az
      cidr_block        = cidr
    }
  ]
}


module "security_groups" {
  source      = "./modules/security_groups"
  vpc_id      = module.vpc.vpc_id
  environment = terraform.workspace
}


module "elb" {
  source          = "./modules/elb"
  subnets         = module.subnets.public_subnet_ids
  security_groups = [module.security_groups.security_group_id]
  environment     = terraform.workspace
}


module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
  elb_dns     = module.elb.elb_dns_name # Ensure this matches ELB module output
  environment = terraform.workspace
}
