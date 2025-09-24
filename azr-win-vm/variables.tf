variable "location" {
  default     = "West Europe"
  description = "Region to deploy the VM to"
}

variable "location_short" {
  default     = "we"
  description = "Region to deploy the VM to"
}

variable "environment" {
  description = "Region to deploy the VM to"
  default     = "common"
}

variable "resource_group_name" {
  description = "RG to deploy resource to"
}

variable "subnet_id" {
  description = "subnet id to deploy resources to"
}

variable "vm_size" {
  default = "Standard_B2ms"
}

variable "admin_password" {
  description = "Admin password to access deployed VM"
}

variable "index_number" {
  default = 01
}

variable "enable_public_ip" {
  default     = false
  description = "Wheter to attach a public IP (true) or no (false)"
}

variable "enable_auto_shutdown" {
  description = "Wheter to enable auto shutdown or not"
  default     = true
}

locals {
  vm = {
    vm_name  = "${var.location_short}-${var.environment}-${var.index_number}-vm"
    nic_name = "${var.location_short}-${var.environment}-${var.index_number}-nic"
  }
}
