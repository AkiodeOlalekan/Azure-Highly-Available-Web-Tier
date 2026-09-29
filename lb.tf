################# create public IP for load balancer #########################

resource "azurerm_public_ip" "ahmed_lb_public_ip" {
  name                = var.LB_public_ip_name
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
  allocation_method   = "Static"
  zones               = ["1", "2", "3"]
}

################## create load balancer ###############################

resource "azurerm_lb" "ahmed_lb" {
  name                = var.load_balancer_name
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ahmed_lb_public_ip.id
  }
}

################# create backend address pool for load balancer ######################################

resource "azurerm_lb_backend_address_pool" "ahmed_lb_backend_pool" {
  loadbalancer_id = azurerm_lb.ahmed_lb.id
  name            = "BackEndAddressPool"
}

################## associate the backend address pool with the network interfaces of the virtual machines ##############

resource "azurerm_network_interface_backend_address_pool_association" "ahmed_nic_backend_pool_association" {
  count                   = var.resource_count
  network_interface_id    = azurerm_network_interface.WindowsNIC[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ahmed_lb_backend_pool.id

}

################### create health probe for load balancer ############################################

resource "azurerm_lb_probe" "ahmed_lb_probe" {
  loadbalancer_id = azurerm_lb.ahmed_lb.id
  name            = "HealthProbe"
  protocol        = "Tcp"
  port            = 80
}

################# create load balancer rule for HTTP ###############################################

resource "azurerm_lb_rule" "ahmed_lb_rule" {
  loadbalancer_id                = azurerm_lb.ahmed_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ahmed_lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.ahmed_lb_probe.id
  disable_outbound_snat          = true
}

########### create outbound rule for load balancer ##############

resource "azurerm_lb_outbound_rule" "ahmed_lb_outbound" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.ahmed_lb.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ahmed_lb_backend_pool.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}
