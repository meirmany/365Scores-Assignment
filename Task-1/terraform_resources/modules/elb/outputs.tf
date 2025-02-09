output "elb_dns_name" {
  description = "DNS name of the ELB"
  value       = aws_lb.app_lb.dns_name
}