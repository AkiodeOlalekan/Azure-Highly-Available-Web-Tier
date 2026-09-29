############## create a resource group ##############
resource "azurerm_resource_group" "AhmedRG" {
  name     = var.RG_name
  location = var.location
}


