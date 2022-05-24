resource "azurerm_lb" "k8s_loadbalancer" {
  name                = "kubernetes-internal"
  location            = var.aks_location
  resource_group_name = azurerm_kubernetes_cluster.cluster.node_resource_group
  sku                 = "Standard"
  tags                = module.tags.tags
}

resource "azurerm_lb_backend_address_pool" "k8s_lb_bkend_addr_pool" {
  loadbalancer_id = azurerm_lb.k8s_loadbalancer.id
  name            = "kubernetes"
}