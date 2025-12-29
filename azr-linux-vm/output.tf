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

# Export public IP with a description
output "public_ip" {
  value       = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
  description = "Public IP address of the VM"
}

# Export IPv6 private IP address
output "vm_private_ipv6" {
  value       = var.enable_ipv6 ? try(azurerm_network_interface.nic.ip_configuration[1].private_ip_address, null) : null
  description = "Private IPv6 address of the VM"
}

# Export IPv6 public IP address
output "public_ipv6" {
  value       = var.enable_ipv6 && var.enable_ipv6_public_ip ? azurerm_public_ip.pip_ipv6[0].ip_address : null
  description = "Public IPv6 address of the VM"
}
