output "azurerm_key_vault" {
  value = azurerm_key_vault.this.id
}

output "pep_pvt_dns_fqdn" {
  precondition {
    condition     = length(azurerm_private_dns_a_record.dns_record) > 0
    error_message = "Private DNS does not exist for the eventhub"
  }
  description = "FQDN for the key vault private endpoint in private dns zone"
  value       = "${azurerm_private_dns_a_record.dns_record[0].name}.${var.private_dns_zone_name}"
}