output "hub_vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "firewall_subnet_id" {
  value = azurerm_subnet.firewall_subnet.id
}