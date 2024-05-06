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