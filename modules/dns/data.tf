data "azurerm_virtual_network" "vnet" {
  count               = var.vnet_link != null ? 1 : 0
  name                = var.vnet_link.vnet_name
  resource_group_name = local.rg
}