output "key_vault_name" {
  value = azurerm_key_vault.this.name
}


output "azurerm_key_vault_key" {
  value = azurerm_key_vault_key.vault_key.name
}