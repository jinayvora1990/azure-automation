
resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  sku                 = var.registry_sku

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.example.id
    ]
  }

  encryption {
    enabled            = true
    key_vault_key_id   = var.azurerm_key_vault_key
    identity_client_id = azurerm_user_assigned_identity.example.client_id
  }
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  name                = var.user_assigned_identity_name
}

resource "azurerm_role_assignment" "crypto_encryption_role_assignment" {
  scope                = var.azurerm_key_vault
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}

