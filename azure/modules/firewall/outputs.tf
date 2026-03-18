output "firewall_private_ip" {
  value = azurerm_firewall.azure_fw.ip_configuration[0].private_ip_address
}