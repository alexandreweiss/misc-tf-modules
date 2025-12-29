variable "customer_name" {
  description = "Customer name for resource naming"
  type        = string
  default     = "contoso"
}

variable "location" {
  default = "eu-west-1"
}

variable "location_short" {
  description = "Short location identifier for resource naming"
  type        = string
  default     = "fra"
}

variable "ubuntu_ami_owners" {
  description = "List of owners for the Ubuntu AMI lookup"
  type        = list(string)
  default     = ["099720109477"]
}

variable "ubuntu_ami_name_pattern" {
  description = "Name pattern for Ubuntu AMI lookup"
  type        = string
  default     = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
}

variable "environment" {
  description = "Environment identifier for resource naming"
  type        = string
  default     = "dev"
}

variable "index_number" {
  description = "Index number for resource naming"
  type        = string
  default     = "01"
}

variable "vm_size" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default     = "ssh-linux-non-prod"
}

variable "subnet_id" {
  description = "subnet id to deploy resources to"
  type        = string
}

variable "vpc_id" {
  description = "VPC id to deploy resources to"
  type        = string
}

variable "user_data" {
  default     = "dummy"
  description = "What to inject into the VM. If dummy, it is bypassed"
}

locals {
  vm = {
    vm_name  = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-vm"
    nic_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-nic"
    pip_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-pip"
    nsg_name = "${var.customer_name}-${var.location_short}-${var.environment}-${var.index_number}-nsg"
  }
}
