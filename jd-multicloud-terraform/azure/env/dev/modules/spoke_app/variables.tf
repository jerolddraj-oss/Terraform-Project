variable "rg" {}
variable "location" {}

output "app_subnet_id" {

  value = azurerm_subnet.app_subnet.id

}