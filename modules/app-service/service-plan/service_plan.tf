locals {
  common_tags    = { module = "redis-cache" }
  rg             = var.resource_group_name
  location       = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}

resource "azurerm_service_plan" "sp" {
  location                     = local.location
  name                         = format("asp-app-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), "-1"/*module.res-id.result*/)
  os_type                      = var.os_type
  resource_group_name          = local.rg
  sku_name                     = var.service_plan_sku
  maximum_elastic_worker_count = var.max_elastic_worker_count
  worker_count                 = var.worker_count
  #  per_site_scaling_enabled     = false
  #  zone_balancing_enabled       = true

  #  app_service_environment_id   = azurerm_app_service_environment_v3.app_service_env.id

  tags = merge(var.tags, local.common_tags, { "resource_type" = "service-plan" })
}

#resource "azurerm_app_service_environment_v3" "app_service_env" {
#  name                = ""
#  resource_group_name = ""
#  subnet_id           = ""
#}