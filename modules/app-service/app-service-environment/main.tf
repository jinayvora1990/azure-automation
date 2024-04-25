locals {
  common_tags = { module = "app-service-environment" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}

resource "azurerm_app_service_environment_v3" "ase" {
  name                = format("ase-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), "1")
  resource_group_name = local.rg
  subnet_id           = data.azurerm_subnet.ase_subnet.id

  allow_new_private_endpoint_connections = var.allow_new_private_endpoint_connections
  dedicated_host_count                   = var.dedicated_host_count
  zone_redundant                         = var.zone_redundant
  internal_load_balancing_mode           = var.internal_load_balancing_mode

  dynamic "cluster_setting" {
    for_each = var.cluster_setting
    content {
      name  = cluster_setting.value.name
      value = cluster_setting.value.value
    }
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "app-service-environment-v3" })
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-asev3-${var.environment}"
  target_resource_id             = azurerm_app_service_environment_v3.ase.id
  eventhub_authorization_rule_id = each.value.event_hub_authorization_rule_resource_id
  eventhub_name                  = each.value.event_hub_name
  log_analytics_destination_type = each.value.log_analytics_destination_type
  log_analytics_workspace_id     = each.value.workspace_resource_id
  partner_solution_id            = each.value.marketplace_partner_resource_id
  storage_account_id             = each.value.storage_account_resource_id

  dynamic "enabled_log" {
    for_each = each.value.log_categories
    content {
      category = enabled_log.value
    }
  }
}