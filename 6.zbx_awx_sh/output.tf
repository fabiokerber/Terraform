output "resource-group" {
  value       = azurerm_resource_group.resource-group.name
  description = "Resource Group"
}

output "vm_resource-group" {
  value       = azurerm_resource_group.vm_resource-group.name
  description = "VM Resource Group"
}

output "computer_name" {
  value       = azurerm_linux_virtual_machine.vm.computer_name
  description = "VM Computer Name"
}

output "admin_username" {
  value       = azurerm_linux_virtual_machine.vm.admin_username
  description = "VM admin username"
}

output "secret_admin_password" {
  value       = azurerm_key_vault_secret.vm_secret.name
  description = "VM Secret admin password"
}

output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
  description = "VM Public IP"
}

output "image_id" {
  value = var.image_id
}