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

data "azurerm_key_vault" "key_vault" {
  name                = var.encryption_config.encryption_key.vault.key_vault_name
  resource_group_name = var.encryption_config.encryption_key.vault.resource_group_name
}