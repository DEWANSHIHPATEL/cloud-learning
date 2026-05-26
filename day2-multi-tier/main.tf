module "vpc" {
  source = "./modules/vpc"
}

module "compute" {
  source    = "./modules/compute"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}

module "db" {
  source     = "./modules/db"
  vpc_id     = module.vpc.vpc_id
  # Passing both unique subnets here
  subnet_ids = [module.vpc.private_subnet_id, module.vpc.private_subnet_b_id]
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "day3-cluster"
  vpc_id       = module.vpc.vpc_id
  # Passing the list containing both subnets
  subnet_ids   = module.vpc.private_subnets
}