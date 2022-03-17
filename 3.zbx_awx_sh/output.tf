output "resource-group" {
  value       = azurerm_resource_group.resource-group.name
  description = "Resource Group"
}

output "vm_resource-group" {
  value       = azurerm_resource_group.vm_resource-group.name
  description = "VM Resource Group"
}

output "computer_name" {
  value       = azurerm_linux_virtual_machine.awx.computer_name
  description = "VM Computer Name"
}

output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.awx.public_ip_address
  description = "VM Public IP"
}