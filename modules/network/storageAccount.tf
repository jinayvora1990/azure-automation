resource "azurerm_storage_account" "storage" {
  provider            = azurerm.avd
  name                = "saavdproduaenorth01"
  resource_group_name = azurerm_resource_group.rg_storage.name
  location            = azurerm_resource_group.rg_storage.location
  #public_network_access_enabled = false
  min_tls_version          = "TLS1_2"
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_storage_account" "avd_image_storage" {
  provider                 = azurerm.avd
  name                     = "saavdimagesprod001"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
}

