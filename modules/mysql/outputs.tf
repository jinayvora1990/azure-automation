output "postgres_fqdn" {
  value = azurerm_mysql_flexible_server.mysql_flexible_server.fqdn
}

output "pep_pvt_dns_fqdn" {
  precondition {
    condition     = length(azurerm_private_dns_a_record.dns_record) > 0
    error_message = "Private DNS does not exist for the eventhub"
  }
  description = "FQDN for mysql server endpoint in private dns zone"
  value       = "${azurerm_private_dns_a_record.dns_record[0].name}.${var.private_dns_zone_name}"
}