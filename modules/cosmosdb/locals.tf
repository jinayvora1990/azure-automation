locals {
  common_tags      = { module = "cosmos-db" }
  location         = lower(var.resource_location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")

  default_failover_locations = [{
    location = local.location
  }]
}