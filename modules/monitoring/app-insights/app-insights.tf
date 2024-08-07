module "res-id" {
  source = "../../utility/random-identifier"
}

resource "azurerm_application_insights" "app_insights" {
  name                = format("appi-%s-%s-%s-%s", var.application_name, var.environment, local.location_shortcode, module.res-id.result)
  application_type    = var.application_type
  resource_group_name = local.rg
  location            = local.location

  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  workspace_id                          = var.workspace_id
  sampling_percentage                   = var.sampling_percentage
  local_authentication_disabled         = var.local_authentication_disabled
  internet_ingestion_enabled            = var.internet_ingestion_enabled
  internet_query_enabled                = var.internet_query_enabled

  tags = merge(var.tags, local.common_tags, { "resource_type" = "app-insights" })
}