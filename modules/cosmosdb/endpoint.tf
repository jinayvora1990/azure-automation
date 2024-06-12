resource "azurerm_private_endpoint" "pep" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = format("cosmon-%s-%s-%s", var.application_name, var.environment, local.region_shortcode)
  location            = local.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.privatelink_subnet[0].id

  private_service_connection {
    name                           = format("%s%s", azurerm_cosmosdb_account.cosmosdb_account.name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb_account.id
    subresource_names              = ["MongoDB"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}
