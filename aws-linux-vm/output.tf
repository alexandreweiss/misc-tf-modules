output "vm_private_ip" {
  value       = module.ec2_instance_linux.private_ip
  description = "Private IP address of the VM"
}
