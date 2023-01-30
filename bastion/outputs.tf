output "bastion_name" {
  value = azurerm_bastion_host.bastion.name
}

output "resource_group_name" {
  value = var.resource_group_name
}
