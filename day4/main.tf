provider "aws" {
  region = "us-east-1" # Change if you use a different region
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source     = "./modules/eks"
  subnet_ids = module.vpc.public_subnet_ids
}