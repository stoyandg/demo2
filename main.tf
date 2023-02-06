provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
  id_vpc = module.networking.id_vpc
}

module "sg" {
  source = "./modules/sg"
  id_vpc = module.networking.id_vpc
  vpc_public_security_group_ids = [module.sg.vpc_public_security_group_ids]
}

module "cluster" {
  source = "./modules/cluster"
  security_groups_private = [module.sg.vpc_private_security_group_ids]
  security_groups_public = [module.sg.vpc_public_security_group_ids]
  both_public_subnets_id = module.networking.both_public_subnets_id
  both_private_subnets_id = module.networking.both_private_subnets_id
  id_vpc = module.networking.id_vpc
  ecr_url = module.ecr.ecr_url
}

module "ecr" {
  source = "./modules/ecr"
}

module "initial-build" {
  source = "./modules/initial-build"

  depends_on = [module.ecr.my_ecr]
}

module "codebuild" {
  source = "./modules/codebuild"
  secgrp = [module.sg.vpc_codebuild_security_group_ids]
  id_vpc = module.networking.id_vpc
  subnets = module.networking.both_private_subnets_id

  depends_on = [module.cluster.my-service]
}