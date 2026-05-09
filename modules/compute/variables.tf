variable "environment" {
    description = "Environment name"
    type        = string
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

variable "subnet_id" {
    description = "Subnet to launch the instance in"
    type        = string
}

variable "security_group_ids" {
    description = "Security group IDs to attach"
    type        = list(string)
}

variable "key_name" {
    description = "Name of an existing EC2 key pair for SSH access"
    type        = string
    default     = ""
}