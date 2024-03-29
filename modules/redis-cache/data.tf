data "azurerm_storage_account" "rdb_sa" {
  name                = var.rdb_storage_account.storage_account_name
  resource_group_name = var.rdb_storage_account.storage_account_rg_name
}

data "azurerm_storage_account" "aof_sa" {
  name                = var.aof_storage_account.storage_account_name
  resource_group_name = var.aof_storage_account.storage_account_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet.name
  virtual_network_name = var.subnet.vnet
  resource_group_name  = var.subnet.resource_group
}

data "azurerm_private_endpoint_connection" "pep_connection" {
  name                = azurerm_private_endpoint.pep.name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_redis_cache.rediscache]
}

data "azurerm_log_analytics_workspace" "log_ws" {
  count               = var.log_analytics.workspace_name != null ? 1 : 0
  name                = var.log_analytics.workspace_name
  resource_group_name = var.log_analytics.resource_group_name
}