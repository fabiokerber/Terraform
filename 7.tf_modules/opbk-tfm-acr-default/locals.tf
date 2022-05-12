# Acure Container Registry
locals {
  acr_name = format("%s%s%s%003d", "azuacr", var.environment, substr(lower(var.acr_name), 0, 8), var.contador)
}
