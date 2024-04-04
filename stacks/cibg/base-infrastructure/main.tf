locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}

module "base_resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = var.rg_name
  tags    = local.tags
}

module "base-infra" {
  source = "../../../modules/base-infrastructure"

  resource_group_name = var.rg_name
  app_name            = var.app_name
  environment         = var.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets

  depends_on = [module.base_resource_group]
}