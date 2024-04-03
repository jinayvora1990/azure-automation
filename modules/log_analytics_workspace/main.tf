locals {
  diagnostic_setting_metric_categories = ["AllMetrics"]
}

resource "azurerm_log_analytics_workspace" "this" {
  name                          = var.workspace_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  local_authentication_disabled = var.local_authentication_disabled
  sku                           = var.sku
  retention_in_days             = var.retention_in_days

  tags = var.tags
}


resource "azurerm_role_assignment" "logs" {
  count                = length(var.contributors)
  scope                = var.resource_group_name
  role_definition_name = "Log Analytics Contributor"
  principal_id         = var.contributors[count.index]
}

