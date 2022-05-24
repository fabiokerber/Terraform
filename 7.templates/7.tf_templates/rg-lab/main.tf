module "resourcegroup" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-rg-default.git?ref=latest"

  # Lock
  lock_level   = var.lock_level
  lock_enabled = var.lock_enabled

  # Resource group
  rg_name     = var.rg_name

  # Tags
  environment = var.environment
  objective   = var.objective
  owner       = var.owner
  system      = var.system
  tags_custom = var.tags_custom
}
