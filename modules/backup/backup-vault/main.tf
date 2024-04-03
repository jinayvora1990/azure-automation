locals {
  common_tags    = { module = "backup-vault" }
  rg             = var.resource_group_name
  location       = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  no_of_resources = 1
}

module "res-id" {
  source = "../../utility/random-identifier"
  count  = local.no_of_resources
}

resource "azurerm_data_protection_backup_vault" "backup_vault" {
  #Required
  name                = format("bvault-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.0.result)
  resource_group_name = local.rg
  datastore_type      = var.datastore_type
  location            = local.location
  redundancy          = var.redundancy

  #Optional
  retention_duration_in_days = var.retention_duration
  soft_delete                = var.soft_delete

  dynamic "identity" {
    for_each = var.identity != null ? [1] : []
    content {
      type = var.identity.type
    }
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "backup-vault" })
}