resource "azurerm_eventhub" "eventhub" {
  count               = length(var.eventhub_config)
  name                = var.eventhub_config[count.index].name
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.eh-namespace.name
  message_retention   = var.eventhub_config[count.index].message_retention
  partition_count     = var.eventhub_config[count.index].partition_count
  status              = var.eventhub_config[count.index].eventhub_status
  dynamic "capture_description" {
    for_each = local.capture_config_list
    content {
      enabled  = true
      encoding = capture_description.value.encoding
      destination {
        blob_container_name = capture_description.value.destination.blob_container_name
        storage_account_id  = capture_description.value.destination.storage_account_id
        archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
        name                = "EventHubArchive.AzureBlockBlob"
      }
      interval_in_seconds = lookup(capture_description.value, "interval_in_seconds", null)
      size_limit_in_bytes = lookup(capture_description.value, "size_limit_in_bytes", null)
      skip_empty_archives = lookup(capture_description.value, "skip_empty_archives", null)
    }
  }
  lifecycle {
    precondition {
      condition     = !(var.sku == "Basic" && var.eventhub_config[count.index].message_retention > 1)
      error_message = "The message retention cannot be greater than 1 for basic tier"
    }
  }
  depends_on = [azurerm_role_assignment.role-assignment]
}

data "azurerm_storage_container" "container" {
  count                = length(local.capture_config_list)
  name                 = local.capture_config_list[count.index].destination.blob_container_name
  storage_account_name = local.capture_config_list[count.index].destination.storage_account_id
}

resource "azurerm_role_assignment" "role-assignment" {
  count                = length(local.capture_config_list)
  principal_id         = azurerm_user_assigned_identity.sa_access.principal_id
  scope                = data.azurerm_storage_container.container[count.index].id
  role_definition_name = "Storage Blob Data Contributor"
}