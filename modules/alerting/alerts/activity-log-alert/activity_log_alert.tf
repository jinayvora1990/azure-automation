
resource "azurerm_monitor_activity_log_alert" "activity_log_alert" {
  for_each            = var.activity_log_alert
  name                = each.key
  resource_group_name = local.rg
  location            = var.resource_location
  scopes              = each.value.scopes
  criteria {
    category          = each.value.criteria.category
    operation_name    = lookup(each.value.criteria, "operation_name", null)
    level             = lookup(each.value.criteria, "level", null)
    status            = lookup(each.value.criteria, "status", null)
    resource_provider = lookup(each.value.criteria, "resource_provider", null)
    resource_type     = lookup(each.value.criteria, "resource_type", null)
    resource_group    = lookup(each.value.criteria, "resource_group", null)
    resource_id       = lookup(each.value.criteria, "resource_id", null)

    dynamic "service_health" {
      for_each = each.value.criteria.service_health == null ? [] : ["service_health"]
      content {
        events    = each.value.criteria.service_health.events
        locations = each.value.criteria.service_health.locations
        services  = each.value.criteria.service_health.services
      }
    }

    dynamic "resource_health" {
      for_each = each.value.criteria.resource_health == null ? [] : ["resource_health"]
      content {
        current  = each.value.criteria.resource_health.current
        previous = each.value.criteria.resource_health.previous
        reason   = each.value.criteria.resource_health.reason
      }
    }
  }
  dynamic "action" {
    for_each = each.value.actions
    content {
      action_group_id = action.value
    }
  }

  tags = var.tags
}