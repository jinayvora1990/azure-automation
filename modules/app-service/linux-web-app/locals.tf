locals {
  common_tags = { module = "app-service" }
  rg       = var.resource_group_name
  location = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  app_insights = try(data.azurerm_application_insights.app_insights[0], {})

  default_app_settings = var.application_insights_enabled ? {
    APPLICATION_INSIGHTS_IKEY             = try(local.app_insights.instrumentation_key, "")
    APPINSIGHTS_INSTRUMENTATIONKEY        = try(local.app_insights.instrumentation_key, "")
    APPLICATIONINSIGHTS_CONNECTION_STRING = try(local.app_insights.connection_string, "")
  } : {}

  artifacts = {
    "WEBSITE_RUN_FROM_PACKAGE" = var.artifact_url
  }

  app_settings = merge(local.default_app_settings, local.artifacts, var.env_vars)

#   default_ip_restrictions_headers = {
#     x_azure_fdid      = null
#     x_fd_health_probe = null
#     x_forwarded_for   = null
#     x_forwarded_host  = null
#   }
}