variable "RG_name" {
  description = "The name of the resource group"
  type        = string
  default     = "AhmedRG"
  
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "Austria East"
}

variable "windows_vm_name" {
  description = "The name of the Windows virtual machine"
  type        = string
  default     = "AhmedWindowsVM"
}

variable "windows_vm_admin_username" {
  description = "The admin username for the Windows virtual machine"
  type        = string
  default     = "AhmedAdmin"
}

variable "windows_vm_admin_password" {
  description = "The admin password for the Windows virtual machine"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "The subscription ID for the Azure provider"
  type        = string
}

variable "resource_count" {
  description = "The number of resources to create"
  type        = number
  default     = 3
}
