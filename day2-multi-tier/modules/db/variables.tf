variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the DB security group will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the DB subnet group"
}

variable "db_password" {
  type        = string
  description = "Password for the database master user"
  sensitive   = true
  default     = "SuperSecretPassword123!" # Change in production
}