terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 2.97.0"
      configuration_aliases = [azurerm.shared_services, azurerm.diti_identity]
    }
  }
}
