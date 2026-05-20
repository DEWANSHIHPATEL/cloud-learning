terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Ensure this matches your configured region
}

# 1. Fetch the latest Ubuntu 22.04 LTS AMI dynamically
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner ID of Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Create a Security Group (Firewall)
resource "aws_security_group" "web_sg" {
  name        = "ec2-web-sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"

  # Inbound Rules: Allow HTTP traffic on Port 80 from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules: Allow the VM to talk to the internet (necessary to download Nginx)
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# 3. Create the EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" # Free Tier eligible instance type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Bootstrapping: Bash script to update packages and start Nginx on first boot
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Terraform-Ubuntu-WebServer"
  }
}

# 4. Output the server's public IP address
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}