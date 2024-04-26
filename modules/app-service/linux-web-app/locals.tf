locals {
  common_tags = { module = "app-service" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }


  default_app_settings = var.application_insights.enabled ? {
    APPLICATION_INSIGHTS_IKEY             = module.app-insights[0].instrumentation_key
    APPINSIGHTS_INSTRUMENTATIONKEY        = module.app-insights[0].instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.app-insights[0].connection_string
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