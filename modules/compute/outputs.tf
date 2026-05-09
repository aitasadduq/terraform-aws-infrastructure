output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP of the web server — visit this in your browser"
  value       = aws_instance.web.public_ip
}

output "public_dns" {
  value = aws_instance.web.public_dns
}