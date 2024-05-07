locals {
  location = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}

resource "azurerm_container_registry" "acr" {
  name                          = format("acr%s%s%s%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), "1")
  resource_group_name           = var.resource_group_name
  location                      = local.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.azure_services_bypass_allowed ? "AzureServices" : "None"
  data_endpoint_enabled         = var.data_endpoint_enabled

  dynamic "identity" {
    for_each = var.encryption_enabled ? [{}] : []

    content {
      type = "UserAssigned"
      identity_ids = [
        azurerm_user_assigned_identity.acr_managed_identity[0].id
      ]
    }
  }

  dynamic "retention_policy" {
    for_each = var.images_retention_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.images_retention_enabled
      days    = var.images_retention_days
    }
  }

  dynamic "trust_policy" {
    for_each = var.trust_policy_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.trust_policy_enabled
    }
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations != null && var.sku == "Premium" ? var.georeplication_locations : []

    content {
      location                  = try(georeplications.value.location, georeplications.value)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, null)
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
      tags                      = try(georeplications.value.tags, null)
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled            = var.encryption_enabled
      key_vault_key_id   = azurerm_key_vault_key.vault_key[0].id
      identity_client_id = azurerm_user_assigned_identity.acr_managed_identity[0].client_id
    }
  }

  dynamic "network_rule_set" {
    for_each = length(concat(var.allowed_cidrs, var.allowed_subnets)) > 0 ? ["enabled"] : []

    content {
      default_action = "Deny"

      dynamic "ip_rule" {
        for_each = var.allowed_cidrs
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }

      dynamic "virtual_network" {
        for_each = var.allowed_subnets
        content {
          action    = "Allow"
          subnet_id = virtual_network.value
        }
      }
    }
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = !var.data_endpoint_enabled || var.sku == "Premium"
      error_message = "Premium SKU is mandatory to enable the data endpoints."
    }
  }
}

resource "azurerm_user_assigned_identity" "acr_managed_identity" {
  count = var.encryption_enabled ? 1 : 0

  resource_group_name = var.resource_group_name
  location            = local.location
  name                = var.user_assigned_identity_name
}

resource "azurerm_role_assignment" "crypto_encryption_role_assignment" {
  count = var.encryption_enabled ? 1 : 0

  scope                = data.azurerm_key_vault.keyvault[0].id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.acr_managed_identity[0].principal_id
}

resource "azurerm_role_assignment" "kv_administrator_role_assignment" {
  count = var.encryption_enabled ? 1 : 0

  scope                = data.azurerm_key_vault.keyvault[0].id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_key" "vault_key" {
  count = var.encryption_enabled ? 1 : 0

  name         = var.azurerm_key_vault_key
  key_vault_id = data.azurerm_key_vault.keyvault[0].id
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

  depends_on = [azurerm_role_assignment.kv_administrator_role_assignment]
}
