data "azurerm_subnet" "mysql_subnet" {
  name                 = var.mysql_subnet.name
  virtual_network_name = var.mysql_subnet.vnet_name
  resource_group_name  = var.mysql_subnet.resource_group
}

data "azurerm_subnet" "privatelink_subnet" {
  count                = var.privatelink_subnet != null ? 1 : 0
  name                 = var.privatelink_subnet.name
  virtual_network_name = var.privatelink_subnet.vnet_name
  resource_group_name  = var.privatelink_subnet.resource_group
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault.name
  resource_group_name = var.keyvault.resource_group
}

data "azurerm_key_vault_secret" "mysql_admin_username" {
  name         = var.keyvault.mysql_admin_username_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "mysql_admin_password" {
  name         = var.keyvault.mysql_admin_password_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}