terraform {
  backend "azurerm" {
    resource_group_name  = "rg-br-tu-awx-redhat"
    storage_account_name = "tfstateawx"
    container_name       = "tfstateawx-files"
    key                  = "OfdZ+8iAo+GNrnqY6lH3Q+whvCsGs/apMKDxu8YtViO8E9JVL1G8obqiyuNg0wuyGuFarXNiMC606psrAfhnxA=="
  }
}