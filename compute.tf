
################# create network interface for windows vm ##############
resource "azurerm_network_interface" "WindowsNIC" {
  count = 3
  name                = "WindowsNIC-${count.index}"
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.VMSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


#################### create a windows virtual machine ##############
resource "azurerm_virtual_machine" "WindowsVM" {
  count = var.resource_count
  name                  = "${var.windows_vm_name}-by-Ahmed-${count.index}"
  location              = azurerm_resource_group.AhmedRG.location
  resource_group_name   = azurerm_resource_group.AhmedRG.name
  network_interface_ids = [azurerm_network_interface.WindowsNIC[count.index].id]
  vm_size               = "Standard_DS1_v2"
  zones                 = [tostring(count.index % 3 + 1)] 

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "myosdisk2-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  

  os_profile {
    computer_name  = "computer2-${count.index}"
    admin_username = var.windows_vm_admin_username
    admin_password = var.windows_vm_admin_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
}

resource "azurerm_virtual_machine_extension" "web_server_install" {
  count               = var.resource_count
  name                = "IISInstall-${count.index}"
  virtual_machine_id  = azurerm_virtual_machine.WindowsVM[count.index].id
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  type_handler_version = "1.10"
  auto_upgrade_minor_version = true
  depends_on = [azurerm_lb_outbound_rule.ahmed_lb_outbound,
  azurerm_network_interface_backend_address_pool_association.ahmed_nic_backend_pool_association]

    settings = jsonencode({
    commandToExecute = "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools; Set-Content -Path 'C:\\inetpub\\wwwroot\\Default.htm' -Value '<h1>Hello from VM ${count.index}</h1>'\""
  })
}

