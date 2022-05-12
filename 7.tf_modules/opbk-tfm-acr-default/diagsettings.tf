data "azurerm_log_analytics_workspace" "workspace" {
  count               = var.diagsettings_enabled ? 1 : 0
  name                = var.log_analytics_workspace[var.environment].workspace_name
  resource_group_name = var.log_analytics_workspace[var.environment].workspace_rg_name
}

resource "azurerm_monitor_diagnostic_setting" "diasettings" {
  count                      = var.diagsettings_enabled && data.azurerm_log_analytics_workspace.workspace != null ? 1 : 0
  name                       = local.acr_name
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace[0].id

  dynamic "log" {
    for_each = var.diagsettings_logs_category
    content {
      category = log.key
      enabled  = log.value

      retention_policy {
        days    = log.value ? var.diagsettings_retention_days : 0
        enabled = log.value
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagsettings_metric_category
    content {
      category = metric.key
      enabled  = metric.value

      retention_policy {
        days    = metric.value ? var.diagsettings_retention_days : 0
        enabled = metric.value
      }
    }
  }
}
