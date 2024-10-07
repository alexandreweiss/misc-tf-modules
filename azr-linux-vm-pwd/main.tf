resource "azurerm_public_ip" "pip" {
  count = var.enable_public_ip ? 1 : 0

  allocation_method   = "Static"
  sku                 = "Standard"
  location            = var.location
  name                = local.vm.pip_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  count = var.enable_public_ip ? 1 : 0

  location            = var.location
  name                = local.vm.nsg_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "forward" {
  count = var.enable_public_ip ? 1 : 0

  name                        = "forward"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  count = var.enable_public_ip ? 1 : 0

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}

resource "azurerm_network_interface" "nic" {
  name                  = local.vm.nic_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  ip_forwarding_enabled = var.enable_ip_forwarding

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.pip[0].id : null
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic-lb" {
  count = var.lb_backend_pool_id != "dummy" ? 1 : 0

  backend_address_pool_id = var.lb_backend_pool_id
  ip_configuration_name   = azurerm_network_interface.nic.ip_configuration[0].name
  network_interface_id    = azurerm_network_interface.nic.id
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                  = local.vm.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = "${local.vm.vm_name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = local.vm.vm_name
  admin_username                  = "admin-lab"
  admin_password                  = var.admin_password
  disable_password_authentication = false

  boot_diagnostics {
  }

  tags        = merge({ environment = var.environment }, var.tags)
  custom_data = var.custom_data != "dummy" ? var.custom_data : null
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_vm" {
  count = var.enable_auto_shutdown ? 1 : 0

  daily_recurrence_time = "2100"
  timezone              = "Romance Standard Time"
  location              = var.location
  virtual_machine_id    = azurerm_linux_virtual_machine.vm.id
  notification_settings {
    enabled = false
  }
}
