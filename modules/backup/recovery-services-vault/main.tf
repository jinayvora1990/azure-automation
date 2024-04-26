locals {
  common_tags = { module = "redis-cache" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  key_rotation_policy = var.encryption_config.encryption_key.rotation_policy
}

module "res-id" {
  source = "../../utility/random-identifier"
}

resource "azurerm_key_vault_key" "encryption_key" {
  count = var.encryption_config != null ? 1 : 0
  name  = format("rsv-kvkey-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  key_type     = "RSA"
  key_size     = 2048
  key_vault_id = data.azurerm_key_vault.key_vault.id

  dynamic "rotation_policy" {
    for_each = var.encryption_config != null ? [1] : []
    content {
      expire_after         = coalesce(local.key_rotation_policy.expire_after, "P90D")
      notify_before_expiry = coalesce(local.key_rotation_policy.notify_before_expiry, "P29D")
      automatic {
        time_before_expiry = coalesce(local.key_rotation_policy.time_before_expiry, "P30D")
      }
    }
  }
}

resource "azurerm_user_assigned_identity" "rsv_managed_identity" {
  name                = format("rsv-id-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name = local.rg
  location            = local.location
}

resource "azurerm_role_assignment" "crypto_encryption_role_assignment" {
  scope                = data.azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.rsv_managed_identity.principal_id
}

resource "azurerm_recovery_services_vault" "vault" {
  #required
  name                = format("rsv-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name = local.rg
  location            = local.location
  sku                 = var.sku

  #optional
  public_network_access_enabled      = false
  immutability                       = var.immutability
  storage_mode_type                  = var.storage_mode_type
  cross_region_restore_enabled       = var.cross_region_restore_enabled
  soft_delete_enabled                = var.soft_delete
  classic_vmware_replication_enabled = var.classic_vmware_replication_enabled

  dynamic "identity" {
    for_each = var.encryption_config != null ? [1] : []
    content {
      type = "UserAssigned"
      identity_ids = [
        azurerm_user_assigned_identity.rsv_managed_identity.id
      ]
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_config != null ? [1] : []
    content {
      infrastructure_encryption_enabled = var.encryption_config.infrastructure_encryption
      key_id                            = azurerm_key_vault_key.encryption_key.id
      use_system_assigned_identity      = false
      user_assigned_identity_id         = azurerm_user_assigned_identity.rsv_managed_identity.id
    }
  }

  dynamic "monitoring" {
    for_each = var.monitoring != null ? [1] : []
    content {
      alerts_for_all_job_failures_enabled            = var.monitoring.alerts_for_all_job_failures
      alerts_for_critical_operation_failures_enabled = var.monitoring.alerts_for_critical_operation_failures
    }
  }

  tags       = merge(var.tags, local.common_tags, { "resource_type" = "recovery-services-vault" })
  depends_on = [azurerm_key_vault_key.encryption_key]
}