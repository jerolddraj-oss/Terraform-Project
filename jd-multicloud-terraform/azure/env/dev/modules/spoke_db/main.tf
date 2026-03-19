resource "azurerm_virtual_network" "db_vnet" {

  name                = "jd-db-vnet"
  location            = var.location
  resource_group_name = var.rg
  address_space       = ["10.3.0.0/16"]
}

resource "azurerm_subnet" "db_subnet" {

  name                 = "db-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.db_vnet.name
  address_prefixes     = ["10.3.1.0/24"]
}