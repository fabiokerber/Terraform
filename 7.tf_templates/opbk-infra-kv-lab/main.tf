module "keyvault" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-kv-default.git?ref=latest"

  # Key Vault
  kv_resource_group_name = var.kv_resource_group_name
  kv_namespace           = var.kv_namespace
  kv_camada              = var.kv_camada
  kv_contador            = var.kv_contador
  diagsettings_enabled   = var.diagsettings_enabled

  # Acessos ao Key vault
  resources_access_kv = var.resources_access_kv
  group_owner_access_kv     = var.group_owner_access_kv

  # Secrets
  secrets = var.secrets

  # Tags
  environment = var.environment
  objective   = var.objective
  owner       = var.owner
  system      = var.system
  tags_custom = var.tags_custom

  providers = {
    azurerm.shared_services    = azurerm.shared_services
    azurerm.diti_identity      = azurerm.diti_identity
    azurerm.diti_gerenciamento = azurerm.diti_gerenciamento
  }
}
