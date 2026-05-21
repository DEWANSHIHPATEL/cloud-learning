module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

module "compute" {
  source      = "./modules/compute"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_id   = module.vpc.public_subnet_id
}

module "db" {
  source      = "./modules/db"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = [module.vpc.private_subnet_id, module.vpc.private_subnet_b_id]
}