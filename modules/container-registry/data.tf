data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault" {
  count = var.encryption_enabled ? 1 : 0

  name                = var.kv_name
  resource_group_name = var.resource_group_name
}