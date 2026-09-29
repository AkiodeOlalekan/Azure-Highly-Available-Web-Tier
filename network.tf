############## create a virtual network ##############
resource "azurerm_virtual_network" "VNET" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
}   

############### create a subnet ##############
resource "azurerm_subnet" "VMSubnet" {   
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.AhmedRG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = [var.subnet_address_prefix]   
}


############# create bastion subnet ##############
resource "azurerm_subnet" "AhmedBastionSubnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.AhmedRG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = [var.bastion_subnet_address_prefix]
}


