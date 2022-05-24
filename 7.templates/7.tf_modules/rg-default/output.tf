# Lock
output "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  value       = var.lock_level
}

output "lock_enabled" {
  description = "Habilitar resource lock?"
  value       = var.lock_enabled
}

# Resource group
output "resource_group" {
  description = "Objeto resource group"
  value       = azurerm_resource_group.resource_group
}

output "rg_name" {
  description = "Nome do resource group"
  value       = azurerm_resource_group.resource_group.name
}

output "rg_location" {
  description = "Localização onde será criado o resource group"
  value       = azurerm_resource_group.resource_group.location
}
