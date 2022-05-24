# Lock
output "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  value       = module.resourcegroup.lock_level
}

output "lock_enabled" {
  description = "Habilitar resource lock?"
  value       = module.resourcegroup.lock_enabled
}

output "rg_name" {
  description = "Nome do resource group"
  value       = module.resourcegroup.rg_name
}

output "rg_location" {
  description = "Localização onde será criado o resource group"
  value       = module.resourcegroup.rg_location
}

# Tags
output "environment" {
  description = "Subscription que o recurso será criado"
  value       = module.resourcegroup.environment
}

output "objective" {
  description = "Objetivo do sistema/recurso"
  value       = module.resourcegroup.objective
}

output "owner" {
  description = "Responsável pelo sistema/recurso"
  value       = module.resourcegroup.owner
}

output "system" {
  description = "Sistema"
  value       = module.resourcegroup.system
}

output "tags_custom" {
  description = "Tags customizadas"
  value       = module.resourcegroup.tags_custom
}
