output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for s in aws_subnet.public : s.id]  # Ensures list format
}