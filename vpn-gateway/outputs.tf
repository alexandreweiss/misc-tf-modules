output "vpn_gateway" {
  description = "VPN GW Object"
  value       = azurerm_virtual_network_gateway.vpn_gw
}

output "vpn_gateway_public_ip" {
  description = "VPN GW Public IP"
  value       = azurerm_public_ip.pip
}
