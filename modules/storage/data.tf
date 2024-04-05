
data "azurerm_subnet" "privatelink_subnet" {
  name                 = var.privatelink_subnet.name
  virtual_network_name = var.privatelink_subnet.vnet_name
  resource_group_name  = var.privatelink_subnet.resource_group
}
