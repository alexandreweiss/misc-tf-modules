output "vm_private_ip" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "Private IP address of the VM"
}

output "nsg_id" {
  value       = var.enable_public_ip ? azurerm_network_security_group.nsg[0].id : null
  description = "ID of the NSG"
}
