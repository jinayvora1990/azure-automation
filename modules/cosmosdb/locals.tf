locals {
  common_tags = { module = "cosmos-db" }
  location    = lower(var.resource_location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.resource_location, substr(local.location, 0, 4))
  default_failover_locations = [{
    location = local.location
  }]
}