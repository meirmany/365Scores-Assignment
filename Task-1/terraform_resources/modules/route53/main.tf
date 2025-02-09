resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "elb_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.elb_dns]   # Fixed incorrect reference
}

