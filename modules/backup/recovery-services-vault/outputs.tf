output "vault_name" {
  description = "The name of the azure recovery services vault"
  value       = azurerm_recovery_services_vault.vault.name
}

output "vault_id" {
  description = "The id of the azure backup vault"
  value       = azurerm_recovery_services_vault.vault.id
}

output "encryption_key" {
  description = "The name of the encryption key for the recovery services vault"
  value       = coalesce(azurerm_key_vault_key.encryption_key[0].name, null)
}