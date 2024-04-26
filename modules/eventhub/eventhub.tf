
resource "azurerm_eventhub" "eventhub" {
  name                = format("evh-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.eh-namespace.name
  message_retention   = var.message_retention
  partition_count     = var.partition_count
  status              = var.eventhub_status
}