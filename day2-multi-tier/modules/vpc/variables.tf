variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "IP range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IP range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "IP range for the private subnet"
  type        = string
  default     = "10.0.10.0/24"
}
variable "private_subnet_b_cidr" {
  description = "IP range for the second private subnet"
  type        = string
  default     = "10.0.11.0/24"
}