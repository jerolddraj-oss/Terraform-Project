resource "azurerm_virtual_network" "web_vnet" {
  name                = "jd-web-vnet"
  location            = var.location
  resource_group_name = var.rg
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "web-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.web_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}