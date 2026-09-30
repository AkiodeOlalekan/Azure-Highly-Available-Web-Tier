variable "subscription_id" {
  description = "The subscription ID for the Azure provider"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "StorageRG"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "Austria East"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "ahmedincloudstoragexx"
}

variable "storage_container_name" {
  description = "The name of the storage container"
  type        = string
  default     = "tfstate"
}