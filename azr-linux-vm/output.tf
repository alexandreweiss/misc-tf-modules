output "vm_private_ip" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "Private IP address of the VM"
}

output "nsg_id" {
  value       = var.enable_public_ip ? azurerm_network_security_group.nsg[0].id : null
  description = "ID of the NSG"
}

# Export NSG name with a description of what it does
output "nsg_name" {
  value       = var.enable_public_ip ? azurerm_network_security_group.nsg[0].name : null
  description = "Name of the NSG"
}
