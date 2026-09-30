############# configure the backend for storing state files ##############

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}


provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

############## create a resource group ##############
resource "azurerm_resource_group" "AhmedRG" {
  name     = var.resource_group_name
  location = var.location
}



############## create a storage account for state files ##############
resource "azurerm_storage_account" "AhmedStorageAccount" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.AhmedRG.name
  location                 = azurerm_resource_group.AhmedRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version       = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }
}

############# storage container for state files ##############
resource "azurerm_storage_container" "AhmedStorageContainer" {
  name               = var.storage_container_name
  storage_account_id = azurerm_storage_account.AhmedStorageAccount.id
  container_access_type = "private"
}

############### output the storage account and container names ##############

output "storage_account_name" {
  value = azurerm_storage_account.AhmedStorageAccount.name
}

output "storage_container_name" {
  value = azurerm_storage_container.AhmedStorageContainer.name
}
