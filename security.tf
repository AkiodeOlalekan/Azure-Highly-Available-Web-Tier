############# create a network security group ##############
resource "azurerm_network_security_group" "VmNSG" {
  name                = "VMNSG"
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name

  security_rule {
    name = "Allow-HTTP-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    description                = "Allow HTTP inbound traffic"

  }
  

  security_rule {
    name = "Allow_Internet_Outbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
    description                = "Allow Internet outbound traffic"
  }

}


############# associate the network security group with the subnet ##############
resource "azurerm_subnet_network_security_group_association" "VMSubnetNSGAssociation" {
  subnet_id                 = azurerm_subnet.VMSubnet.id
  network_security_group_id = azurerm_network_security_group.VmNSG.id
}
