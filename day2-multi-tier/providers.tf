terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # This block configures your remote state storage and locking
  backend "s3" {
    bucket         = "dewanshi-tf-state-bucket" # <-- Change this to your actual S3 bucket name
    key            = "day2/multi-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}