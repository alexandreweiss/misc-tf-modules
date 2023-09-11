variable "resource_group_name" {
  description = "Resource group to create circuit in"
}

variable "location" {
  description = "Location to create circuit in"
}

variable "subnet_id" {
  description = "Subnet ID of the subnet containing the ARS"
}
