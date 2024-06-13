locals {
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  environment      = lower(var.environment)
  vnet_name        = "vnet-${var.app_name}-${local.environment}-${local.region_shortcode}-${module.res-id.result}"
  if_ddos_enabled  = var.create_ddos_plan ? [{}] : []
}