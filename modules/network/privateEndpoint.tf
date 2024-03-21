resource "azurerm_private_endpoint" "afpe" {
#  provider            = azurerm.avd
  for_each = var.subnets
  name                = "pe-saavdproduaenorth01-file"
  location            = azurerm_resource_group.base_rg.location
  resource_group_name = azurerm_resource_group.base_rg.name
  subnet_id           = azurerm_subnet.subnet[each.key].id

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

### Create a File Storage Account
resource "azurerm_storage_account" "storage" {
#  provider            = azurerm.avd
  name                = "saavdproduaenorth01"
  resource_group_name = azurerm_resource_group.base_rg.name
  location            = azurerm_resource_group.base_rg.location
  #public_network_access_enabled = false
  min_tls_version          = "TLS1_2"
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"

  identity {
    type = "SystemAssigned"
  }
}