locals {
  common_tags = { module = "event-hub" }
  rg       = var.resource_group_name
  location = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}