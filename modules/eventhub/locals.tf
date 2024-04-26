locals {
  common_tags = { module = "service-plan" }
  rg       = var.resource_group_name
  location = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
}