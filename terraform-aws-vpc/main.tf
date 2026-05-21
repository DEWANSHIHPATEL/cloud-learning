terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. Create the Custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = "10.0.0.0/16" # Defines the IP range for the entire VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

# 2. Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24" # A slice of the VPC IP range
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true # Automatically assigns a public IP to instances in this subnet

  tags = {
    Name = "Public-Subnet-Web"
  }
}

# 3. Create a Private Subnet (No internet access)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.2.0/24" # A separate slice of the VPC IP range
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private-Subnet-DB"
  }
}

# 4. Create an Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "VPC-Internet-Gateway"
  }
}

# 5. Create a Route Table for the Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  # Route rule: Direct all outbound traffic (0.0.0.0/0) to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# 6. Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
output "vpc_id" {
  description = "ID of our custom VPC"
  value       = aws_vpc.custom_vpc.id
}

output "public_subnet_id" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the Private Subnet"
  value       = aws_subnet.private_subnet.id
}