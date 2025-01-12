variable "resource_group_name" {
  description = "Resource group to create circuit in"
}

variable "location" {
  description = "Location to create VPN GW in"
}

variable "gateway_name" {
  description = "name of the VPN gateway"
}

variable "gw_subnet_id" {
  description = "subnet id of the GatewaySubnet"
}

variable "gw_sku" {
  default     = "VpnGw1"
  description = "Size of the VPN Gateway"
}
