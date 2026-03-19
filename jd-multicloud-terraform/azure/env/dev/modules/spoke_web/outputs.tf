output "web_vnet_name" {
  value = azurerm_virtual_network.web_vnet.name
}

output "web_vnet_id" {
  value = azurerm_virtual_network.web_vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}