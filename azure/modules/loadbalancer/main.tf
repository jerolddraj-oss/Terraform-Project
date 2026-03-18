resource "azurerm_public_ip" "web_lb_pip" {
  name                = "jd-web-lb-pip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "web_lb" {
  name                = "jd-web-lb"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "web-frontend"
    public_ip_address_id = azurerm_public_ip.web_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web_backend" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "web-backend-pool"
}

resource "azurerm_lb_probe" "web_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "http-probe"
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "web_rule" {
  loadbalancer_id                = azurerm_lb.web_lb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "web-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_backend.id]
  probe_id                       = azurerm_lb_probe.web_probe.id
}

# ---------------- APP INTERNAL LOAD BALANCER ----------------

resource "azurerm_lb" "app_lb" {
  name                = "jd-app-lb"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "app-frontend"
    subnet_id                     = var.app_subnet
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "app_backend" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "app-backend-pool"
}

resource "azurerm_lb_probe" "app_probe" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "app-probe"
  port            = 8080
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "app_rule" {
  loadbalancer_id                = azurerm_lb.app_lb.id
  name                           = "app-rule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "app-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_backend.id]
  probe_id                       = azurerm_lb_probe.app_probe.id
}