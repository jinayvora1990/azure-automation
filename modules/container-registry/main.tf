
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_location
  tags = {
    owners = "jinay.vora@thoughtworks.com"
    project = "beach"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = var.registry_sku

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.example.id
    ]
  }

  encryption {
    enabled            = true
    key_vault_key_id   = data.azurerm_key_vault_key.example.id
    identity_client_id = azurerm_user_assigned_identity.example.client_id
  }
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = var.user_assigned_identity_name
}

# resource "azurerm_role_assignment" "admin_access_role_assignment" {
#   scope                = data.azurerm_key_vault.encryption.id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = azurerm_user_assigned_identity.example.principal_id
# }

resource "azurerm_role_assignment" "crypto_encryption_role_assignment" {
  scope                = data.azurerm_key_vault.encryption.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}