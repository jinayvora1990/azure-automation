output "vault_name" {
  description = "The name of the azure recovery services vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.name
}

output "backup_vault_id" {
  description = "The id of the azure recovery services vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.id
}
