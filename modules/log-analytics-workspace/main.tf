resource "azurerm_log_analytics_workspace" "this" {
  name                          = format("law-%s-%s-%s-%s", var.application_name, var.environment, var.resource_location, "1")
  resource_group_name           = var.resource_group_name
  location                      = var.resource_location
  local_authentication_disabled = var.local_authentication_disabled
  sku                           = var.sku
  retention_in_days             = var.retention_in_days

  tags = var.tags
}

resource "azurerm_role_assignment" "logs" {
  count                = length(var.contributors)
  scope                = azurerm_log_analytics_workspace.this.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = var.contributors[count.index]
}