output "resource_group_name" {
    description = "The name of the resource group"
    value = azurerm_resource_group.AhmedRG.name
}

output "vm_names" {
    description = "The names of the virtual machines"
    value = azurerm_virtual_machine.WindowsVM[*].name
}

output "vm_private_ip_addresses" {
    description = "The private IP addresses of the virtual machines"
    value = azurerm_network_interface.WindowsNIC[*].private_ip_address
}

output "load_balancer_public_ip_Address" {
    description = "The public IP address of the load balancer"
    value = azurerm_public_ip.ahmed_lb_public_ip.ip_address
    
}