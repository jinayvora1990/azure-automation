locals {
  common_tags = { module = "service-plan" }
  rg          = var.resource_group_name
  location    = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}

module "res-id" {
  source = "../../utility/random-identifier"
}

resource "azurerm_service_plan" "sp" {
  location                     = local.location
  name                         = format("asp-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
  os_type                      = var.os_type
  resource_group_name          = local.rg
  sku_name                     = var.service_plan_sku
  maximum_elastic_worker_count = var.max_elastic_worker_count
  worker_count                 = var.worker_count

  tags = merge(var.tags, local.common_tags, { "resource_type" = "service-plan" })
}

