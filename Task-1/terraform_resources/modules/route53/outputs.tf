output "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  value       = aws_route53_zone.main.id
}
