data "azurerm_service_plan" "existing_service_plan" {
  count               = var.existing_service_plan!=null ? 1 : 0
  name                = var.existing_service_plan.name
  resource_group_name = var.existing_service_plan.resource_group_name
}

data "azurerm_subnet" "app_service_subnet" {
  name                 = var.web_app_subnet.name
  virtual_network_name = var.web_app_subnet.vnet_name
  resource_group_name  = var.web_app_subnet.resource_group
}

data "azurerm_key_vault" "key_vault" {
  name                = var.custom_domain.certificate.vault.name
  resource_group_name = var.custom_domain.certificate.vault.resource_group
}

// Now Read the Certificate
data "azurerm_key_vault_secret" "certificate" {
  name         = var.custom_domain.certificate.name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
# data "azurerm_storage_account" "rdb_sa" {
#   name                = var.rdb_storage_account.storage_account_name
#   resource_group_name = var.rdb_storage_account.resource_group_name
# }
#
# data "azurerm_storage_account" "aof_sa" {
#   name                = var.aof_storage_account.storage_account_name
#   resource_group_name = var.aof_storage_account.resource_group_name
# }
#
# data "azurerm_subnet" "redis_subnet" {
#   name                 = var.redis_subnet.name
#   virtual_network_name = var.redis_subnet.vnet_name
#   resource_group_name  = var.redis_subnet.resource_group
# }
#
# data "azurerm_subnet" "privatelink_subnet" {
#   name                 = var.privatelink_subnet.name
#   virtual_network_name = var.privatelink_subnet.vnet_name
#   resource_group_name  = var.privatelink_subnet.resource_group
# }
#
# data "azurerm_private_endpoint_connection" "pep_connection" {
#   name                = azurerm_private_endpoint.pep.name
#   resource_group_name = var.resource_group_name
#   depends_on          = [azurerm_redis_cache.rediscache]
# }
#
# data "azurerm_log_analytics_workspace" "log_ws" {
#   count               = var.log_analytics.workspace_name != null ? 1 : 0
#   name                = var.log_analytics.workspace_name
#   resource_group_name = var.log_analytics.resource_group_name
# }