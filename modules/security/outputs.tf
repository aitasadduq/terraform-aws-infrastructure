output "web_sg_id" {
  value = aws_security_group.web.id
}

output "private_sg_id" {
  value = aws_security_group.private.id
}