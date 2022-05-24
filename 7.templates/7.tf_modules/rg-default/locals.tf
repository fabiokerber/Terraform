locals {
  rg_name = format("%s%s%s%s", "azu-rg-", var.environment, "-", substr(lower(var.rg_name), 0, 8))
}