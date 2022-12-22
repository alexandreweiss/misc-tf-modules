resource "azurerm_network_interface" "nic" {
  name                = local.vm.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.enable_public_ip ? azurerm_public_ip.pip.id : ""
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  admin_password        = var.admin_password
  admin_username        = "admin-lab"
  computer_name         = local.vm.vm_name
  location              = var.location
  name                  = local.vm.vm_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  os_disk {
    name                 = "${local.vm.vm_name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer = "windows-11"
    sku = "win11-21h2-pro"
    version = "latest"
  }

  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_public_ip" "pip" {
  count = var.enable_public_ip ? 1 : 0

  allocation_method = "Dynamic"
  location = var.location
  name = "${local.vm.vm_name}-pip"
  resource_group_name = var.resource_group_name
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_vm" {
  daily_recurrence_time = "2100"
  timezone = "Romance Standard Time"
  location = var.location
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  notification_settings {
    enabled = false
  }
}