locals {
  common_tags = { module = "app-service" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  elastic_premium_sku_list        = ["EP1", "EP2", "EP3"]
  consumption_sku_list            = ["Y1"]
  elastic_sku_list                = concat(local.elastic_premium_sku_list, local.consumption_sku_list)
  service_plan_sku                = var.existing_service_plan != null ? data.azurerm_service_plan.existing_service_plan[0].sku_name : var.service_plan_sku
  is_service_plan_elastic         = contains(local.elastic_sku_list, local.service_plan_sku)
  is_service_plan_consumption     = contains(local.consumption_sku_list, local.service_plan_sku)
  is_service_plan_elastic_premium = contains(local.elastic_premium_sku_list, local.service_plan_sku)

  artifacts = {
    "WEBSITE_RUN_FROM_PACKAGE" = var.artifact_url
  }

  app_settings = merge(local.artifacts, var.env_vars)

  #   default_ip_restrictions_headers = {
  #     x_azure_fdid      = null
  #     x_fd_health_probe = null
  #     x_forwarded_for   = null
  #     x_forwarded_host  = null
  #   }
}