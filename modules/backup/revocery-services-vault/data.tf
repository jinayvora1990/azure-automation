data "azurerm_subnet" "privatelink_subnet" {
  name                 = var.privatelink_subnet.name
  virtual_network_name = var.privatelink_subnet.vnet_name
  resource_group_name  = var.privatelink_subnet.resource_group
}

data "azurerm_private_endpoint_connection" "pep_connection" {
  name                = azurerm_private_endpoint.pep.name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_recovery_services_vault.vault]
}