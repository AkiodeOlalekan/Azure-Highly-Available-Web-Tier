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

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "VNET"
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
  
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "VMs-Subnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix of the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "bastion_subnet_name" {
  description = "The name of the bastion subnet"
  type        = string
  default     = "AzureBastionSubnet"
}

variable "bastion_subnet_address_prefix" {
  description = "The address prefix of the bastion subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "network_security_group_name" {
  description = "The name of the network security group"
  type        = string
  default     = "NSG"
}

variable "windows_vm_name" {
  description = "The name of the Windows virtual machine"
  type        = string
  default     = "WindowsVM"
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

variable "windows_vm_size" {
  description = "The size of the Windows virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "LoadBalancer"
}

variable "LB_public_ip_name" {
  description = "The name of the public IP address for the load balancer"
  type        = string
  default     = "LB-PublicIP"
}