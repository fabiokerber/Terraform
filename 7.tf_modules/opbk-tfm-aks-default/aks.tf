resource "azurerm_kubernetes_cluster" "cluster" {
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone,
    azurerm_role_assignment.pvtdnszone,
    azurerm_role_assignment.vnet,
    azurerm_role_assignment.sub
  ]

  name                = local.aks_name
  location            = var.aks_location
  resource_group_name = var.aks_rg_name
  sku_tier            = var.sku_name
  dns_prefix          = local.dns_prefix

  identity {
    #type = var.identity_type
    type                      = "UserAssigned"
    user_assigned_identity_id = azurerm_user_assigned_identity.pvtdnszone.id
  }

  role_based_access_control {
    enabled = var.aks_rbac_control
  }

  addon_profile {
    azure_policy {
      enabled = var.aks_azure_policy
    }
    oms_agent {
      enabled                    = var.aks_oms_agent
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganalytics[0].id
    }
  }

  enable_pod_security_policy = var.pod_security_policy
  kubernetes_version         = var.aks_kubernetes_version
  private_cluster_enabled    = var.aks_private_cluster
  private_dns_zone_id        = azurerm_private_dns_zone.private_dns_zone.id

  network_profile {
    network_plugin     = var.aks_network_profile.network_plugin
    network_policy     = var.aks_network_profile.network_policy
    load_balancer_sku  = var.aks_network_profile.load_balancer_sku
    dns_service_ip     = var.aks_network_profile.dns_service_ip
    service_cidr       = var.aks_network_profile.service_cidr
    docker_bridge_cidr = var.aks_network_profile.docker_bridge_cidr
    outbound_type      = var.aks_network_profile.outbound_type
  }

  default_node_pool {
    enable_auto_scaling    = var.aks_system_node_pool.enable_auto_scaling
    enable_host_encryption = var.aks_system_node_pool.enable_host_encryption
    enable_node_public_ip  = var.aks_system_node_pool.enable_node_public_ip
    max_pods               = var.aks_system_node_pool.max_pods
    name                   = var.aks_system_node_pool.name
    node_count             = var.aks_system_node_pool.node_count
    max_count              = var.aks_system_node_pool.max_count == false ? null : var.aks_system_node_pool.max_count
    min_count              = var.aks_system_node_pool.min_count == false ? null : var.aks_system_node_pool.min_count
    orchestrator_version   = var.aks_system_node_pool.orchestrator_version
    os_disk_size_gb        = var.aks_system_node_pool.os_disk_size_gb
    os_disk_type           = var.aks_system_node_pool.os_disk_type
    type                   = var.aks_system_node_pool.type
    vm_size                = var.aks_system_node_pool.vm_size
    vnet_subnet_id         = data.azurerm_subnet.subnet[0].id
    tags                   = module.tags.tags
  }

  tags = module.tags.tags
}
