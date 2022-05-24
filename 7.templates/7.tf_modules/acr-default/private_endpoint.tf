module "private_endpoint" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-pvtend-default.git?ref=latest"

  # Private endpoint
  private_endpoint_name          = local.acr_name
  private_connection_resource_id = azurerm_container_registry.acr.id
  subresource_name               = var.subresource_name

  # Tags
  environment  = var.environment
  objective    = var.objective
  owner        = var.owner
  system       = var.system
  centro_custo = var.centro_custo
  repositorio  = var.repositorio
  backend_sa   = var.backend_sa
  backend_key  = var.backend_key
  tags_custom  = var.tags_custom

  providers = {
    azurerm.shared_services = azurerm.shared_services
    azurerm.diti_identity   = azurerm.diti_identity
  }
}