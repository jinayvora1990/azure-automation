module "res-id" {
  source = "../utility/random-identifier"
}

resource "azurerm_eventhub_namespace" "eh-namespace" {
  location                      = local.location
  name                          = format("evhns-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  auto_inflate_enabled          = var.auto_inflate_enabled
  maximum_throughput_units      = var.maximum_throughput_units
  public_network_access_enabled = var.public_network_access_enabled
  zone_redundant                = var.zone_redundant

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sa_access.id]
  }

  dynamic "network_rulesets" {
    for_each = var.network_rulesets != null && var.sku != "Basic" ? ["network_rulesets"] : []
    content {
      default_action                 = var.network_rulesets.default_action
      public_network_access_enabled  = var.public_network_access_enabled
      trusted_service_access_enabled = lookup(var.network_rulesets, "trusted_service_access_enabled", null)
      dynamic "virtual_network_rule" {
        for_each = lookup(var.network_rulesets, "virtual_network_rules", [])
        content {
          subnet_id                                       = virtual_network_rule.value.subnet_id
          ignore_missing_virtual_network_service_endpoint = lookup(virtual_network_rule.value, "ignore_missing_virtual_network_service_endpoint", null)
        }
      }
      dynamic "ip_rule" {
        for_each = lookup(var.network_rulesets, "ip_rules", [])
        content {
          ip_mask = ip_rule.value.ip_mask
          action  = lookup(ip_rule.value, "action", null)
        }
      }
    }
  }
  lifecycle {
    precondition {
      condition     = var.auto_inflate_enabled || var.maximum_throughput_units < 1
      error_message = "The max throughput units cannot be given if auto inflate is disabled"
    }
  }
  tags = merge(var.tags, local.common_tags, { "resource_type" = "eventhub-namespace" })
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-event-hub-${var.environment}"
  target_resource_id             = azurerm_eventhub_namespace.eh-namespace.id
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

  dynamic "enabled_log" {
    for_each = each.value.log_groups
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.metric_categories
    content {
      category = metric.value
    }
  }
  depends_on = [azurerm_user_assigned_identity.sa_access]
}

resource "azurerm_user_assigned_identity" "sa_access" {
  location            = local.location
  name                = "storage-account-access-identity"
  resource_group_name = local.rg
}

resource "azurerm_private_endpoint" "pep" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = format("pep-evhns-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)))
  location            = local.location
  resource_group_name = local.rg
  subnet_id           = data.azurerm_subnet.privatelink_subnet[0].id

  private_service_connection {
    name                           = format("%s%s", azurerm_eventhub_namespace.eh-namespace.name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_eventhub_namespace.eh-namespace.id
    subresource_names              = ["namespace"]
  }
  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}