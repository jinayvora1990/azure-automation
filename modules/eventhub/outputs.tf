output "eventhub_id" {
  description = "The id of the eventhub"
  value = azurerm_eventhub.eventhub.id
}

output "eventhub_namespace" {
  value = azurerm_eventhub.eventhub.namespace_name
}

output "eventhub_partition_ids" {
  value = azurerm_eventhub.eventhub.partition_ids
}