output "azurerm_key_vault" {
  value = azurerm_key_vault.this.id
}


output "azurerm_key_vault_key" {
  value = azurerm_key_vault_key.vault_key.id
}