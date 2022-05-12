module "aks" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-aks-default.git?ref=refactoring"

  # Cluster AKS
  aks_name               = var.aks_name
  aks_contador           = var.aks_contador
  aks_rg_name            = var.aks_rg_name
  aks_kubernetes_version = var.aks_kubernetes_version
  aks_system_node_pool   = var.aks_system_node_pool

  # Diagnostic settings
  diagsettings_enabled = var.diagsettings_enabled

  # Subnet
  aks_vnet_subnet = var.aks_vnet_subnet

  # Azure Container Registry
  acr = var.acr

  # Node pools adicionais
  aks_node_pool = var.aks_node_pool

  # Tags
  environment = var.environment
  objective   = var.objective
  owner       = var.owner
  system      = var.system
  repositorio = var.repositorio
  backend_sa  = var.backend_sa
  backend_key = var.backend_key
  tags_custom = var.tags_custom
}
