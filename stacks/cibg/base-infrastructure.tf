locals {
  base_infra_rg = format("rg-%s-%s-%s-network", local.application_name, local.environment, local.region_shortcode)
}

module "base_infra_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.base_infra_rg
  tags    = local.tags
}

module "base-infra" {
  source = "../../modules/base-infrastructure"

  resource_group_name = module.base_infra_resource_group.rg_name
  app_name            = local.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets
}