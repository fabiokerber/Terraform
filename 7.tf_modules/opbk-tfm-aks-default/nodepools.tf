resource "azurerm_kubernetes_cluster_node_pool" "nodepools" {
  for_each               = var.aks_node_pool
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.cluster.id
  name                   = each.value.name
  vm_size                = each.value.vm_size
  node_count             = each.value.node_count
  enable_auto_scaling    = each.value.enable_auto_scaling
  enable_host_encryption = each.value.enable_host_encryption
  enable_node_public_ip  = each.value.enable_node_public_ip
  max_pods               = each.value.max_pods
  max_count              = each.value.enable_auto_scaling == false ? null : each.value.max_count
  min_count              = each.value.enable_auto_scaling == false ? null : each.value.min_count
  orchestrator_version   = each.value.orchestrator_version
  os_disk_size_gb        = each.value.os_disk_size_gb
  os_disk_type           = each.value.os_disk_type
  mode                   = each.value.mode
  vnet_subnet_id         = data.azurerm_subnet.subnet[0].id
  tags                   = module.tags.tags
}
