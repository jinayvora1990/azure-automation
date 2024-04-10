resource "azurerm_private_endpoint" "sa" {
  name                = format("pep-sa-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location            = local.location
  resource_group_name = var.resource_group
  subnet_id           = data.azurerm_subnet.privatelink_subnet.id

  private_service_connection {
    name                           = format("%s%s", azurerm_storage_account.storeacc.name, "-privatelink")
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
    subresource_names              = ["Blob", "Table", "Queue", "File", "Web", "Dfs"]
  }

  tags = merge(var.tags, { "resource_type" = "private-endpoint" })
}

