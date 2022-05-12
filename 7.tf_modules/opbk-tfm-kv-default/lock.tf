resource "azurerm_management_lock" "resource_lock" {
  count      = var.lock_enabled == true && var.lock_level != null ? length(var.lock_level) : 0
  name       = "resource-lock-${element(var.lock_level, count.index)}"
  scope      = azurerm_key_vault.key_vault.id
  lock_level = element(var.lock_level, count.index)
  notes      = "This resource is ${element(var.lock_level, count.index)}"
}
