resource "azurerm_private_endpoint" "example" {
  #  for_each = var.network_rules.subnet_ids
  name                         = "key-vault-private-endpoint"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  subnet_id                    = var.network_acls.virtual_network_subnet_ids
  private_service_connection {
    name                           = "key-vault-endpoint"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
  }
}