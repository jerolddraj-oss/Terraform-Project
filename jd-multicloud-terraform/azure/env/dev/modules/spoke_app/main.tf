resource "azurerm_virtual_network" "app_vnet" {

  name                = "jd-app-vnet"
  location            = var.location
  resource_group_name = var.rg
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "app_subnet" {

  name                 = "app-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}