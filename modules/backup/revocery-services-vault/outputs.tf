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
  value       = coalesce(azurerm_key_vault_key.encryption_key.0.name, null)
}

output "vault_tenant_ids" {
  description = "The tenant ids of the azure backup vault"
  value       = [for identity in azurerm_recovery_services_vault.vault.identity : identity.tenant_id]
}

output "principal_ids" {
  description = "The principal ids of the azure backup vault"
  value       = [for identity in azurerm_recovery_services_vault.vault.identity : identity.principal_id]
}

output "redis_cache_private_endpoint" {
  description = "id of the Recovery Services Vault Private Endpoint"
  value       = azurerm_private_endpoint.pep.id
}

output "redis_cache_private_endpoint_ip" {
  description = "server private endpoint IPv4 Addresses"
  value       = element(concat(data.azurerm_private_endpoint_connection.pep_connection.private_service_connection.0.private_ip_address, [
    ""
  ]), 0)
}