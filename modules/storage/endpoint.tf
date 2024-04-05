resource "azurerm_private_endpoint" "example" {
#  for_each = var.network_rules.subnet_ids
  name                         = "storage-account-private-endpoint"
  location                     = var.location
  resource_group_name          = var.resource_group
  subnet_id                    = var.network_rules.subnet_ids
  private_service_connection {
    name                           = "storage-endpoint"
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
  }
}