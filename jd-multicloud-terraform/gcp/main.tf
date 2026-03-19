module "network" {

  source = "./modules/network"

}

module "webtier" {

  source = "./modules/webtier"

  network = module.network.network_name

}

module "apptier" {

  source = "./modules/apptier"

  network = module.network.network_name

}

module "dbtier" {

  source = "./modules/dbtier"

  network = module.network.network_name

}