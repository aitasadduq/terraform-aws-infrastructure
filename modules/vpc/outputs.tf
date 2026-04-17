output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.main_public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.main_private_subnet[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main_gateway.id
}