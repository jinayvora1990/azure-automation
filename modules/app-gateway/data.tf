data "azurerm_subnet" "appgw_subnet" {
  name                 = var.appgw_subnet.name
  virtual_network_name = var.appgw_subnet.vnet_name
  resource_group_name  = var.appgw_subnet.resource_group
}