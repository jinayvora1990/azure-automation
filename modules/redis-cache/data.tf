data "azurerm_private_endpoint_connection" "pep_connection" {
  name                = azurerm_private_endpoint.pep.name
  resource_group_name = local.rg
  depends_on          = [azurerm_redis_cache.rediscache]
}

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