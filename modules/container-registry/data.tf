data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault" {
  name                = var.kv_name
  resource_group_name = var.resource_group_name
}