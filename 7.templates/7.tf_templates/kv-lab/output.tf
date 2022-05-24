output "kv_resource_group_name" {
  description = "Resource group do Key vault"
  value       = module.keyvault.kv_resource_group_name
}

output "kv_name" {
  description = "Nome do Key vault"
  value       = module.keyvault.kv_name
}

output "group_owner_access_kv" {
  description = "Owner do Key vault em tu e ti"
  value       = module.keyvault.group_owner_access_kv
}

output "secrets_name" {
  description = "Secrets do key vault"
  value       = module.keyvault.secrets_name
}
