 resource "azurerm_network_interface" "nic" {

  count = 2

  name                = "${var.vm_prefix}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {

    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

  }

}

 resource "azurerm_windows_virtual_machine" "vm" {

  count = 1

  name                = "${var.vm_prefix}-vm-${count.index}"
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_B2s"

  admin_username      = "azureadmin"
  admin_password      = "Password123!"

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

   source_image_reference {

    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"

  }

}

