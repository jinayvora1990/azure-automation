resource "azurerm_private_endpoint" "afpe" {
  provider            = azurerm.avd
  name                = "pe-saavdproduaenorth01-file"
  location            = azurerm_resource_group.rg_storage.location
  resource_group_name = azurerm_resource_group.rg_storage.name
  subnet_id           = azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "psc-file-01"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
  private_dns_zone_group {

    name                 = "dns-file-01"
    private_dns_zone_ids = ["/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-dns-uaenorth-01/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]
  }
}

resource "azurerm_private_endpoint" "blob_pe" {
  provider            = azurerm.avd
  name                = "pe-saavdimagesprod01-blob"
  location            = azurerm_resource_group.rg_storage.location
  resource_group_name = azurerm_resource_group.rg_storage.name
  subnet_id           = azurerm_subnet.private_endpoint_subnet.id


  private_service_connection {
    name                           = "psc-blob-01"
    private_connection_resource_id = azurerm_storage_account.avd_image_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
  private_dns_zone_group {
    name                 = "dns-blob-01"
    private_dns_zone_ids = ["/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-dns-uaenorth-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
  }
}
