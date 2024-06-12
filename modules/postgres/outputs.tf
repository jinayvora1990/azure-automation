output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.postgresql_flexible_server.fqdn
}

# output "pep_pvt_dns_fqdn" {
#   description = "FQDN for the postgres server private endpoint in private dns zone"
#   value       = var.privatelink_subnet != null && var.private_dns_zone_name != null ? "${azurerm_private_dns_a_record.dns_record[0].name}.${var.private_dns_zone_name}" : null
# }