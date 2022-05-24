# API Management
output "acr_name" {
  description = "Nome do API Management"
  value       = module.acr.acr_name
}
output "contador" {
  description = "Contador do API Management"
  value       = module.acr.contador
}
output "acr_rg_name" {
  description = "Resource group do API Management"
  value       = module.acr.acr_rg_name
}
output "acr_location" {
  description = "Localização da API Management"
  value       = module.acr.acr_location
}
# Tags=
output "environment" {
  description = "Subscrição onde o recurso será criado"
  value       = module.acr.environment
}
output "system" {
  description = "Sistema"
  value       = module.acr.system
}

output "objective" {
  description = "Objetivo do sistema/recurso"
  value       = module.acr.objective
}
output "owner" {
  description = "Responsável pelo sistema/recurso"
  value       = module.acr.owner
}
output "tags_custom" {
  description = "Tags customizadas"
  value       = var.tags_custom
}
