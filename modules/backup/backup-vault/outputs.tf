output "vault_name" {
  description = "The name of the azure recovery services vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.name
}

output "backup_vault_id" {
  description = "The id of the azure recovery services vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.id
}

output "backup_vault_tenant_ids" {
  description = "The tenant ids of the azure recovery services vault"
  value       = {
    for identity in azurerm_data_protection_backup_vault.backup_vault.identity : identity.name => identity.tenant_id
  }
}

output "backup_vault_principal_ids" {
  description = "The principal ids of the azure recovery services vault"
  value       = {
    for identity in azurerm_data_protection_backup_vault.backup_vault.identity : identity.name => identity.principal_id
  }
}
