resource "azurerm_monitor_scheduled_query_rules_alert_v2" "log_search_alert" {
  for_each             = var.log_search_alerts
  name                 = each.value.name #TODO: name add here
  location             = var.resource_location
  resource_group_name  = local.rg
  scopes               = each.value.scopes
  severity             = each.value.severity
  window_duration      = each.value.window_duration
  evaluation_frequency = each.value.evaluation_frequency

  criteria {
    operator                = each.value.criteria.operator
    query                   = each.value.criteria.query
    threshold               = each.value.criteria.threshold
    time_aggregation_method = each.value.criteria.time_aggregation_method
    metric_measure_column   = each.value.criteria.metric_measure_column
    resource_id_column      = each.value.criteria.resource_id_column
    dynamic "dimension" {
      for_each = each.value.criteria.dimension != null ? ["dimension"] : []
      content {
        name     = each.value.criteria.dimension.name
        operator = each.value.criteria.dimension.operator
        values   = each.value.criteria.dimension.values
      }
    }
    dynamic "failing_periods" {
      for_each = each.value.criteria.failing_periods
      content {
        minimum_failing_periods_to_trigger_alert = each.value.criteria.failing_periods.minimum_failing_periods_to_trigger_alert
        number_of_evaluation_periods             = each.value.criteria.failing_periods.number_of_evaluation_periods
      }
    }
  }

  action {
    action_groups = each.value.actions
  }

  tags = var.tags
}