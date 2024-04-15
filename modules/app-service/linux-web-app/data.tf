data "azurerm_service_plan" "existing_service_plan" {
  count               = var.existing_service_plan != null ? 1 : 0
  name                = var.existing_service_plan.name
  resource_group_name = var.existing_service_plan.resource_group_name
}

data "azurerm_application_insights" "app_insights" {
  count = var.application_insights_enabled && var.application_insights_id != null ? 1 : 0

  name                = split("/", var.application_insights_id)[8]
  resource_group_name = split("/", var.application_insights_id)[4]
}

data "azurerm_subnet" "app_service_subnet" {
  count = var.web_app_subnet != null ? 1:0
  name                 = var.web_app_subnet.name
  virtual_network_name = var.web_app_subnet.vnet_name
  resource_group_name  = var.web_app_subnet.resource_group
}

data "azurerm_key_vault" "key_vault" {
  count               = var.custom_domain != null && try(var.custom_domain.certificate != null, false) ? 1 : 0
  name                = var.custom_domain.certificate.vault.name
  resource_group_name = var.custom_domain.certificate.vault.resource_group
}

// Now Read the Certificate
data "azurerm_key_vault_secret" "certificate" {
  count        = var.custom_domain != null && try(var.custom_domain.certificate != null, false) ? 1 : 0
  name         = var.custom_domain.certificate.name
  key_vault_id = data.azurerm_key_vault.key_vault.0.id
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