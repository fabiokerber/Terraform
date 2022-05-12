# Acure Container Registry
locals {
  aks_name              = format("%s%s%s%s%s%003d", "azu-aks-", var.environment, "-", substr(lower(var.aks_name), 0, 8), "-", var.aks_contador)
  dns_prefix            = format("%s%s", local.aks_name, "-dns")
  iac_rg_name           = format("%s%s%s%s%s%s", "NT_", var.aks_rg_name, "_", local.aks_name, "_", var.aks_location)
  pvtdnszone_name       = format("%s%s", "pvtdnszone-", local.aks_name)
  sub_name              = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, var.aks_vnet_subnet.vnet_rg_name)
  aks_user_assigned     = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, azurerm_kubernetes_cluster.cluster.node_resource_group)
  private_dns_zone_name = format("%s%s", local.aks_name, ".privatelink.brazilsouth.azmk8s.io")
}



