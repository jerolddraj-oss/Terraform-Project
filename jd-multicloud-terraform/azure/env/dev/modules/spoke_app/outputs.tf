output "web_vnet_name" {
  value = azurerm_virtual_network.app_vnet
}

output "web_vnet_id" {
  value = azurerm_virtual_network.app_vnet
}

output "web_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}