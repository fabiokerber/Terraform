# Usuário de gestão de secrets. É feito pelo sp que executa o terraform
# resource "azurerm_key_vault_access_policy" "set_secrets" {
#   key_vault_id       = azurerm_key_vault.key_vault.id
#   tenant_id          = data.azurerm_client_config.current.tenant_id
#   object_id          = data.azurerm_client_config.current.object_id
#   secret_permissions = var.sp_secret_permissions
# }

resource "azurerm_key_vault_secret" "keyvault_secrets" {
  depends_on   = [module.private_endpoint, azurerm_key_vault_access_policy.group_owner_kv, azurerm_key_vault_access_policy.group_owner_kv] # Incluído para resolver o problema "StatusCode=403/Forbidden - does not have secrets get permission on key vault"
  for_each     = var.secrets
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.key_vault.id
}
