resource "azurerm_public_ip" "fw_pip" {

  name                = "jd-fw-ip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_firewall_policy" "jd_fw_policy" {

  name                = "jd-firewall-policy"
  resource_group_name = var.rg
  location            = var.location

}

resource "azurerm_firewall" "azure_fw" {

  name                = "jd-azure-fw"
  location            = var.location
  resource_group_name = var.rg

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  firewall_policy_id = azurerm_firewall_policy.jd_fw_policy.id

  ip_configuration {

    name                 = "fw-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id

  }

}

resource "azurerm_firewall_policy_rule_collection_group" "jd_fw_rules" {

  name               = "jd-fw-rules"
  firewall_policy_id = azurerm_firewall_policy.jd_fw_policy.id
  priority           = 100

  network_rule_collection {

    name     = "network-rules"
    priority = 100
    action   = "Allow"

    rule {

      name = "internet-to-web"

      protocols = ["TCP"]

      source_addresses = ["*"]

      destination_addresses = ["10.1.1.0/24"]

      destination_ports = ["80","443"]

    }

    rule {

      name = "web-to-app"

      protocols = ["TCP"]

      source_addresses = ["10.1.0.0/16"]

      destination_addresses = ["10.2.0.0/16"]

      destination_ports = ["8080"]

    }

    rule {

      name = "app-to-db"

      protocols = ["TCP"]

      source_addresses = ["10.2.0.0/16"]

      destination_addresses = ["10.3.0.0/16"]

      destination_ports = ["1433"]

    }

  }

}