output "resource-group" {
  value       = azurerm_resource_group.resource-group.name
  description = "Resource Group"
}

output "resource-group_full" {
  value       = azurerm_resource_group.resource-group
  description = "Resource Group"
}