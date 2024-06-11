locals {
  location = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}