output "vpc_id" {
  description = "The ID of the default VPC"
  value       = aws_default_vpc.default.id
}

output "subnet_id" {
  description = "The ID of the default subnet in ap-south-1a"
  value       = aws_default_subnet.default_az1.id
}



