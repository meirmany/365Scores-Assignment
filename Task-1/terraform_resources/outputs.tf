output "vpc_id" {
  value = module.vpc.vpc_id
}

output "elb_dns" {
  value = module.elb.elb_dns_name
}
