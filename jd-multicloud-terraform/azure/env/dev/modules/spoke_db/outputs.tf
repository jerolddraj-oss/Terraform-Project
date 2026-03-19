output "web_vnet_name" {
  value = azurerm_virtual_network.db_vnet
}

output "web_vnet_id" {
  value = azurerm_virtual_network.db_vnet
}

output "web_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}