module "base-infra" {
  count  = var.provision_modules.network ? 1 : 0
  source = "../../modules/base-infrastructure"

  resource_group_name = module.resource_group[0].rg_name
  app_name            = var.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets
}