resource "azurerm_virtual_network_peering" "hub_to_web" {

  name                      = "hub-to-web"
  resource_group_name       = var.rg
  virtual_network_name      = var.hub_vnet
  remote_virtual_network_id = var.web_vnet

  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "web_to_hub" {

  name                      = "web-to-hub"
  resource_group_name       = var.rg
  virtual_network_name      = var.web_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  allow_virtual_network_access = true
}