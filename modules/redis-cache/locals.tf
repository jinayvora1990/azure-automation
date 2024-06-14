locals {
  common_tags = { module = "redis-cache" }
  rg          = var.resource_group_name
  location    = var.resource_location
  sku         = var.cache_tier.sku_name
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.resource_location, substr(var.resource_location, 0, 4))
  environment        = lower(var.environment)
}