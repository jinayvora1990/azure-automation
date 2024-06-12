module "base-infra" {
  source = "../../modules/base-infrastructure"

  resource_group_name = module.resource_group.rg_name
  app_name            = var.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets
}