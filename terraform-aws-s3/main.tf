terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # You can change this to your preferred region
}

# Create an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-learning-bucket-dewanshi-123" # CHANGE THIS NAME

  tags = {
    Name        = "My first S3 Bucket"
    Environment = "Dev"
  }
}