module "res-id" {
  source = "../utility/random-identifier"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                          = format("law-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(local.location, 0, 4)), module.res-id.result)
  resource_group_name           = var.resource_group_name
  location                      = var.resource_location
  local_authentication_disabled = var.local_authentication_disabled
  sku                           = var.sku
  retention_in_days             = var.retention_in_days

  tags = var.tags
}

resource "azurerm_role_assignment" "law_contributor_apps" {
  count                = length(data.azuread_application.applications)
  scope                = azurerm_log_analytics_workspace.this.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = data.azuread_application.applications[count.index].object_id
}

resource "azurerm_role_assignment" "law_contributor_users" {
  count                = length(data.azuread_user.users)
  scope                = azurerm_log_analytics_workspace.this.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = data.azuread_user.users[count.index].object_id
}