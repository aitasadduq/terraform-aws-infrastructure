variable "vpc_id" {
  type        = string
  description = "VPC ID to create security groups in"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH (your IP address)"
  type        = string
}