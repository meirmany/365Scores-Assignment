resource "aws_lb" "app_lb" {
  name               = "app-lb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups  
  subnets            = var.subnets          

  tags = {
    Name = "ALB-${var.environment}"
  }
}
