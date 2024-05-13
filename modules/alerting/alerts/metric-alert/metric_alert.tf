resource "azurerm_monitor_metric_alert" "metric_alert" {
  for_each            = var.metric_alerts
  name                = each.key
  resource_group_name = local.rg
  scopes              = each.value.scopes
  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      metric_name      = criteria.value.metric_name
      metric_namespace = criteria.value.metric_namespace
      aggregation      = criteria.value.aggregation
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold
      dynamic "dimension" {
        for_each = criteria.value.dimension != null ? criteria.value.dimension : []
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
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