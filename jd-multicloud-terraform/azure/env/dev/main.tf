
# ---------------- RESOURCE GROUP ----------------


resource "azurerm_resource_group" "jd_rg" {
  name     = "jd-rg"
  location = "East US"
}

# ---------------- HUB MODULE ----------------

module "hub" {

  source = "./modules/hub"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

}



module "firewall" {

  source = "./modules/firewall"

  rg        = azurerm_resource_group.jd_rg.name
  location  = azurerm_resource_group.jd_rg.location
  subnet_id = module.hub.firewall_subnet_id
}

# ---------------- SPOKE MODULES ----------------

module "web_spoke" {

  source = "./modules/spoke_web"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

}

module "app_spoke" {

  source = "./modules/spoke_app"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

}

module "db_spoke" {

  source = "./modules/spoke_db"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

}

# ---------------- LOAD BALANCER ----------------

module "web_lb" {

  source = "./modules/loadbalancer"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

  app_subnet = module.web_spoke.web_subnet_id

}

# ---------------- WEB VMS ----------------

module "web_vm" {

  source = "./modules/vm"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location
  subnet_id = module.web_spoke.web_subnet_id

  vm_prefix = "web"

  backend_pool_id = module.web_lb.web_backend_pool_id

}

resource "azurerm_network_interface_backend_address_pool_association" "web_lb_assoc" {

  count = 2

  network_interface_id    = module.web_vm.nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = module.web_lb.web_backend_pool_id

}

# ---------------- APP VMS ----------------

module "app_vm" {

  source = "./modules/vm"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location
  subnet_id = module.app_spoke.app_subnet_id

  vm_prefix = "app"

}

# ---------------- DB VMS ----------------

module "db_vm" {

  source = "./modules/vm"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

  subnet_id = module.db_spoke.db_subnet_id

  vm_prefix = "db"

}

# ---------------- VNET PEERING ----------------

module "vnet_peering" {

  source = "./modules/vnet_peering"

  rg = azurerm_resource_group.jd_rg.name

  hub_vnet     = module.hub.hub_vnet_name
  hub_vnet_id  = module.hub.hub_vnet_id

  web_vnet     = module.web_spoke.web_vnet_id
  web_vnet_name = module.web_spoke.web_vnet_name

}

# ---------------- ROUTE TABLE ----------------

module "web_route_table" {

  source = "./modules/route_table"

  rg       = azurerm_resource_group.jd_rg.name
  location = azurerm_resource_group.jd_rg.location

  subnet_id           = module.web_spoke.web_subnet_id
  firewall_private_ip = module.firewall.firewall_private_ip

}

# ---------------- LOAD BALANCER ----------------

module "loadbalancer" {

  source = "./modules/loadbalancer"

  rg        = azurerm_resource_group.jd_rg.name
  location  = azurerm_resource_group.jd_rg.location
  app_subnet = module.app_spoke.app_subnet_id

}