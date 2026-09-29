
########## create bastion public ip ##############

resource "azurerm_public_ip" "AhmedBastionPublicIP" {
  name                = "AhmedBastionPublicIP"
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

############ create bastion host ##############

resource "azurerm_bastion_host" "AhmedBastionHost" {
  name                = "AhmedBastionHost"
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name

  ip_configuration {
    name                 = "AhmedBastionIPConfig"
    subnet_id            = azurerm_subnet.AhmedBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.AhmedBastionPublicIP.id
  }
}
