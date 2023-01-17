variable "resource_group_name" {
  description = "Resource group to create circuit in"
}

variable "location" {
  description = "Location to create circuit in"
}

variable "gateway_name" {
  description = "name of the ER gateway"
}

variable "gw_subnet_id" {
  description = "subnet id of the GatewaySubnet"
}

variable "gw_sku" {
  default     = "Basic"
  description = "Size of the ER Gateway"
}
