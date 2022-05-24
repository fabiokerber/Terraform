locals {
  kv_name = format("%s%s%s%s%s%s%s%003d", "azu-kv-", var.environment, "-", substr(lower(var.kv_namespace), 0, 8), "-", var.kv_camada, "-", var.kv_contador)

  access_only_tu_ti       = tolist(["GD4253_DS_AZ"])
  list_with_item_in_front = distinct(concat(local.access_only_tu_ti, var.group_owner))
  access_th_pr            = slice(local.list_with_item_in_front, 1, length(local.list_with_item_in_front))
  group_owner             = contains(["tu", "ti"], var.environment) ? var.group_owner : local.access_th_pr

  subnet_pvtend   = var.environment != "do" ? [data.azurerm_subnet.vnet_pvtend_opbk[0].id] : [data.azurerm_subnet.vnet_pvtend_pltfrma[0].id]
  virtual_network = concat(local.subnet_pvtend, [data.azurerm_subnet.vnet_jumpserver.id])
}
