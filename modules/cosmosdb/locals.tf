locals {
  common_tags      = { module = "cosmos-db" }
  location         = lower(var.resource_location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  default_failover_locations = [{
    location = local.location
  }]
}