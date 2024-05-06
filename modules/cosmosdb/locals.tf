locals {
  common_tags = { module = "cosmos-db" }
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  default_failover_locations = [{
    location = local.location
  }]
}