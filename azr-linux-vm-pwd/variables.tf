variable "customer_name" {
  description = "Name of customer to be used in resources"
  default     = "contoso"
}

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

variable "tags" {
  description = "Tags to be created on the VM"
  default     = {}
}

variable "resource_group_name" {
  description = "RG to deploy resource to"
}

variable "subnet_id" {
  description = "subnet id to deploy resources to"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "index_number" {
  default = 01
}

variable "enable_auto_shutdown" {
  description = "Wheter to enable auto shutdown or not"
  default     = true
}

variable "enable_ip_forwarding" {
  description = "Enable IP forwarding on the NIC"
  default     = false
}

variable "enable_public_ip" {
  description = "Attach a public IP"
  default     = false
}

variable "lb_backend_pool_id" {
  description = "LB Backend ID to associate NIC to"
  default     = "dummy"
}

variable "custom_data" {
  default     = "dummy"
  description = "What to inject into the VM. If dummy, it is bypassed"
}

variable "admin_password" {
  description = "Password to access deployed VM"
}

locals {
  vm = {
    vm_name  = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-vm"
    nic_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-nic"
    pip_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-pip"
    nsg_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-nsg"
  }
}
