variable "rg" {}
variable "location" {}

output "db_subnet_id" {

  value = azurerm_subnet.db_subnet.id

}