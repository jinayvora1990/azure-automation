resource "azurerm_private_endpoint" "kv" {
  name                = format("kv-vault-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location                     = var.location
  resource_group_name          = var.resource_group_name
  subnet_id                    = data.azurerm_subnet.privatelink_subnet.id
  private_service_connection {
    name                           = format("%s%s", azurerm_key_vault.this.name, "-privatelink")
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names = ["vault"]
  }
}
