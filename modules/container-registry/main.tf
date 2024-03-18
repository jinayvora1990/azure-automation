
data "azurerm_client_config" "current" {
}

resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  sku                 = var.registry_sku

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_managed_identity.id
    ]
  }

  encryption {
    enabled            = true
    key_vault_key_id   = azurerm_key_vault_key.vault_key.id
    identity_client_id = azurerm_user_assigned_identity.acr_managed_identity.client_id
  }
}

resource "azurerm_user_assigned_identity" "acr_managed_identity" {
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  name                = var.user_assigned_identity_name
}

resource "azurerm_role_assignment" "crypto_encryption_role_assignment" {
  scope                = var.azurerm_key_vault
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.acr_managed_identity.principal_id
}

resource "azurerm_role_assignment" "kv_administrator_role_assignment" {
  scope                = var.azurerm_key_vault
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_key" "vault_key" {
  name         = var.azurerm_key_vault_key
  key_vault_id = var.azurerm_key_vault
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [ azurerm_role_assignment.kv_administrator_role_assignment ]
}
