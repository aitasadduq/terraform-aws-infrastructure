variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  type        = string
  default     = "ait-terraform-state-040426"
  description = "S3 bucket name for Terraform state"
}

variable lock_table_name {
  type        = string
  default     = "terraform-state-lock"
  description = "DynamoDB table name for state locking"
}
