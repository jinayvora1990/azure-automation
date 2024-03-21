resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.base_rg.name
  address_space       = var.vnet_address_spaces
  dns_servers         = var.dns_servers
}
