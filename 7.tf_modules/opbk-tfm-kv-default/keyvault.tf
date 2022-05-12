resource "azurerm_key_vault" "key_vault" {
  name                       = local.kv_name
  location                   = var.kv_location
  resource_group_name        = var.kv_resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.environment != "pr" ? var.purge_protection_enabled : var.purge_protection_pr_enabled

  network_acls {
    bypass                     = "AzureServices"
    default_action             = var.kv_default_action
    virtual_network_subnet_ids = local.virtual_network
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = module.tags.tags
}
