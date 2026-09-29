############## create a virtual network ##############
resource "azurerm_virtual_network" "VNET" {
  name                = "VNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
}   


############### create a subnet ##############
resource "azurerm_subnet" "VMSubnet" {   
  name                 = "VMSubnet"
  resource_group_name  = azurerm_resource_group.AhmedRG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = ["10.0.1.0/24"]   
}


############# create bastion subnet ##############
resource "azurerm_subnet" "AhmedBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.AhmedRG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = ["10.0.2.0/24"]
}



