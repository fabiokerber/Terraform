data "azurerm_log_analytics_workspace" "loganalytics" {
  count               = var.diagsettings_enabled ? 1 : 0
  name                = var.log_analytics_workspace[var.environment].workspace_name
  resource_group_name = var.log_analytics_workspace[var.environment].workspace_rg_name
}

resource "azurerm_monitor_diagnostic_setting" "diasettings" {
  count                      = var.diagsettings_enabled && data.azurerm_log_analytics_workspace.loganalytics != null ? 1 : 0
  name                       = local.aks_name
  target_resource_id         = azurerm_kubernetes_cluster.cluster.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganalytics[0].id

  dynamic "log" {
    for_each = var.diagsettings_log_category
    content {
      category = log.key
      enabled  = log.value

      retention_policy {
        days    = log.value == true ? var.diagsettings_retention_days : 0
        enabled = log.value ? true : false
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagsettings_metric_category
    content {
      category = metric.key
      enabled  = metric.value
      retention_policy {
        enabled = metric.value ? true : false
        days    = metric.value == true ? var.diagsettings_retention_days : 0
      }
    }
  }
}
