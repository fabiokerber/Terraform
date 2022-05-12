# Configurações para fazer o attach do ACR com o AKS
data "azurerm_container_registry" "acr" {
  count               = var.acr.acr_name != "" && var.acr.acr_rg_name != "" ? 1 : 0
  name                = var.acr.acr_name
  resource_group_name = var.acr.acr_rg_name
}

resource "azurerm_role_assignment" "aks_acr_pull_allowed" {
  count                = var.acr.acr_name != "" && var.acr.acr_rg_name != "" ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  scope                = data.azurerm_container_registry.acr[0].id
  role_definition_name = var.acr_role_definition_name
}
