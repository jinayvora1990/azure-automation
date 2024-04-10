
resource "azurerm_private_endpoint" "file_sa" {
  count               = length(var.file_shares) > 0 ? 1:0
  name                = format("pep-sa-file-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location                     = var.location
  resource_group_name          = var.resource_group
  subnet_id                    = data.azurerm_subnet.privatelink_subnet.id
  private_service_connection {
    name                           = format("%s%s", azurerm_storage_account.storeacc.name, "-privatelink")
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
    subresource_names = ["File"]
    #subresource_names = ["Blob","Table","Queue","File"]
  }
}


resource "azurerm_private_endpoint" "Blob_sa" {
  count               = length(var.containers_list) > 0 ? 1:0
  name                = format("pep-sa-file-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location                     = var.location
  resource_group_name          = var.resource_group
  subnet_id                    = data.azurerm_subnet.privatelink_subnet.id
  private_service_connection {
    name                           = format("%s%s", azurerm_storage_account.storeacc.name, "-privatelink")
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
    subresource_names = ["Blob"]
    #subresource_names = ["Blob","Table","Queue","File"]
  }
}


resource "azurerm_private_endpoint" "table_sa" {
  count               = length(var.tables) > 0 ? 1:0
  name                = format("pep-sa-file-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location                     = var.location
  resource_group_name          = var.resource_group
  subnet_id                    = data.azurerm_subnet.privatelink_subnet.id
  private_service_connection {
    name                           = format("%s%s", azurerm_storage_account.storeacc.name, "-privatelink")
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
    subresource_names = ["Table"]
    #subresource_names = ["Blob","Table","Queue","File"]
  }
}


resource "azurerm_private_endpoint" "queue_sa" {
  count               = length(var.queues) > 0 ? 1:0
  name                = format("pep-sa-file-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location                     = var.location
  resource_group_name          = var.resource_group
  subnet_id                    = data.azurerm_subnet.privatelink_subnet.id
  private_service_connection {
    name                           = format("%s%s", azurerm_storage_account.storeacc.name, "-privatelink")
    private_connection_resource_id = azurerm_storage_account.storeacc.id
    is_manual_connection           = false
    subresource_names = ["Queue"]
    #subresource_names = ["Blob","Table","Queue","File"]
  }
}

