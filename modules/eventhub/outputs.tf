output "eventhub_id" {
  description = "The id of the eventhub"
  value       = azurerm_eventhub.eventhub[*].id
}

output "eventhub_namespace" {
  description = "The eventhub namespace name"
  value       = azurerm_eventhub_namespace.eh-namespace.name
}

output "eventhub_partition_ids" {
  description = "The list of partition ids of the eventhub"
  value       = azurerm_eventhub.eventhub[*].partition_ids
}

output "pep_pvt_dns_fqdn" {
  description = "FQDN for the eventhub private endpoint in private dns zone"
  value       = var.privatelink_subnet != null && var.private_dns_zone_name != null ? "${azurerm_private_dns_a_record.dns_record[0].name}.${var.private_dns_zone_name}" : null
}