resource "azurerm_route_table" "spoke_rt" {

  name                = "jd-spoke-rt"
  location            = var.location
  resource_group_name = var.rg

}

resource "azurerm_route" "default_route" {

  name                   = "default-to-firewall"
  resource_group_name    = var.rg
  route_table_name       = azurerm_route_table.spoke_rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip

}

resource "azurerm_subnet_route_table_association" "web_rt_assoc" {

  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.spoke_rt.id

}