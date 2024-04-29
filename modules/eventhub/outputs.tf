/*output "eventhub_id" {      #TODO: Change this
  description = "The id of the eventhub"
  value = azurerm_eventhub.eventhub.*.id
}

output "eventhub_namespace" {
  value = azurerm_eventhub.eventhub.0.namespace_name
}

output "eventhub_partition_ids" {
  value = azurerm_eventhub.eventhub.*.partition_ids
}*/