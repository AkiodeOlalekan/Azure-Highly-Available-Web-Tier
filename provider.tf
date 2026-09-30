############ terraform provider configuration ##############

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "StorageRG"
    storage_account_name = "ahmedincloudstoragexx"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

############# Configure the Microsoft Azure Provider ###############

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
