data "azurerm_virtual_network" "virtual_network" {
  count = (var.virtual_network_name != null && var.virtual_network_resource_group != null) ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet.name
  virtual_network_name = var.subnet.vnet
  resource_group_name  = var.subnet.resource_group
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault.name
  resource_group_name = var.keyvault.resource_group
}

data "azurerm_key_vault_secret" "postgres_admin_username" {
  name         = var.keyvault.postgres_admin_username_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "postgres_admin_password" {
  name         = var.keyvault.postgres_admin_password_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.private_dns_zone_name != null ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_resource_group_name
}