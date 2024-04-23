locals {
  acr_rg = format("rg-%s-%s-%s-acr", local.application_name, local.environment, local.region_shortcode)
}

module "acr_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.acr_rg
  tags    = local.tags
}

module "acr" {
  source = "../../modules/container-registry"

  resource_group_name = module.acr_resource_group.rg_name
  application_name    = local.application_name
  environment         = local.environment
}
