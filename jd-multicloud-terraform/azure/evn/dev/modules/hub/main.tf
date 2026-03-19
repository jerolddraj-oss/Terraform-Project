resource "azurerm_virtual_network" "hub_vnet" {

  name                = "jd-hub-vnet"
  location            = var.location
  resource_group_name = var.rg
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "firewall_subnet" {

  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "gateway_subnet" {

  name                 = "GatewaySubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}