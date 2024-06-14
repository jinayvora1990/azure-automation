locals {
  owners      = var.owners
  environment = var.environment
  location    = lower(var.resource_location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.resource_location, substr(local.location, 0, 4))
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
  kv_name                            = substr(format("kv-%s-%s-%s-%s", var.application_name, var.environment, local.location_shortcode, module.res-id.result), 0, 24)
}