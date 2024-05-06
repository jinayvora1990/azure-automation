data "azurerm_storage_account" "rdb_sa" {
  count               = var.rdb_backup_enabled ? 1 : 0
  name                = var.rdb_storage_account.storage_account_name
  resource_group_name = var.rdb_storage_account.resource_group_name
}

data "azurerm_storage_account" "aof_sa" {
  count               = var.aof_backup_enabled ? 1 : 0
  name                = var.aof_storage_account.storage_account_name
  resource_group_name = var.aof_storage_account.resource_group_name
}

data "azurerm_subnet" "redis_subnet" {
  count                = var.redis_subnet != null ? 1 : 0
  name                 = var.redis_subnet.name
  virtual_network_name = var.redis_subnet.vnet_name
  resource_group_name  = var.redis_subnet.resource_group
}

data "azurerm_subnet" "privatelink_subnet" {
  count                = var.privatelink_subnet != null ? 1 : 0
  name                 = var.privatelink_subnet.name
  virtual_network_name = var.privatelink_subnet.vnet_name
  resource_group_name  = var.privatelink_subnet.resource_group
}

data "azurerm_private_endpoint_connection" "pep_connection" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = azurerm_private_endpoint.pep[0].name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_redis_cache.rediscache]
}