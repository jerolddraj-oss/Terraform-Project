module "vpc" {

  source = "./modules/vpc"

}

module "webtier" {

  source = "./modules/webtier"

  vpc_id = module.vpc.vpc_id

}

module "apptier" {

  source = "./modules/apptier"

  vpc_id = module.vpc.vpc_id

}

module "dbtier" {

  source = "./modules/dbtier"

  vpc_id = module.vpc.vpc_id

}