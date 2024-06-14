locals {
  location = lower(var.location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.location, substr(local.location, 0, 4))
  environment        = lower(var.environment)
  vnet_name          = "vnet-${var.app_name}-${local.environment}-${local.location_shortcode}-${module.res-id.result}"
  if_ddos_enabled    = var.create_ddos_plan ? [{}] : []
}