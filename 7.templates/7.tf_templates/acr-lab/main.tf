module "acr" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-acr-default.git?ref=latest"

  # Azure Container Registry
  contador    = var.contador
  acr_rg_name = var.acr_rg_name
  acr_name    = var.acr_name

  diagsettings_enabled = var.diagsettings_enabled

  # Tags
  environment = var.environment
  objective   = var.objective
  owner       = var.owner
  system      = var.system
  repositorio = var.repositorio
  backend_sa  = var.backend_sa
  backend_key = var.backend_key
  tags_custom = var.tags_custom

  providers = {
    azurerm.shared_services = azurerm.shared_services
    azurerm.diti_identity   = azurerm.diti_identity
  }
}