output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "Private IP address of the VM"
}