variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the EC2 security group will be created"
}

variable "subnet_id" {
  type        = string
  description = "The public subnet ID to place the EC2 instance"
}