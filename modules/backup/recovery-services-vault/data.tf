data "azurerm_key_vault" "key_vault" {
  name                = var.encryption_config.encryption_key.vault.key_vault_name
  resource_group_name = var.encryption_config.encryption_key.vault.resource_group_name
}