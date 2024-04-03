locals {
  common_tags    = { module = "redis-cache" }
  rg             = var.resource_group_name
  location       = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  no_of_resources = 3
}

module "res-id" {
  source = "../../utility/random-identifier"
  count  = local.no_of_resources
}

resource "azurerm_recovery_services_vault" "vault" {
  #required
  name                = format("rsv-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.0.result)
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

  dynamic "encryption" {
    for_each = var.encryption != null ? [1] : []
    content {
      infrastructure_encryption_enabled = var.encryption.infrastructure_encryption
      key_id                            = var.encryption.key_id
      use_system_assigned_identity      = var.encryption.use_system_assigned_identity
      user_assigned_identity_id         = var.encryption.user_assigned_identity_id
    }
  }

  dynamic "monitoring" {
    for_each = var.monitoring != null ? [1] : []
    content {
      alerts_for_all_job_failures_enabled            = var.monitoring.alerts_for_all_job_failures
      alerts_for_critical_operation_failures_enabled = var.monitoring.alerts_for_critical_operation_failures
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [1] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.ids
    }
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "recovery-services-vault" })
}

resource "azurerm_private_endpoint" "pep" {
  name                = format("rsv-pep-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.1.result)
  location            = local.location
  resource_group_name = local.rg
  subnet_id           = data.azurerm_subnet.privatelink_subnet.id

  private_service_connection {
    name                           = format("rsv-pl-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.2.result)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_recovery_services_vault.vault.id
    subresource_names              = ["AzureSiteRecovery"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}