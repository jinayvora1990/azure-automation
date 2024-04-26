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

  tags = merge(var.tags, local.common_tags, { "resource_type" = "eventhub-namespace" })
}