terraform {
  required_version = ">= 1.0.5"

  backend "azurerm" {
    subscription_id     = "03b738da-610d-46ab-a5cb-27268d693818" # Plataforma - DevOps
    resource_group_name = "azu-rg-do-pltfrma"

    # Terraform remote backend sustentação (tu e do)
    storage_account_name = "azusadotrrfrm001"
    container_name       = "tfstate-sustentacao"

    # Terraform remote backend negócio (tu, ti ,th e pr)
    # storage_account_name = "azusadotrrfrm002"
    # container_name       = "tfstate-negocio"

    key = "opban8/opbk-infra-acr-lab/opbk-infra-acr-lab.tfstate"
  }
}
