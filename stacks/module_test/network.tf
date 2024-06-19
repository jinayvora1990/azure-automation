module "base-infra" {
  count  = var.provision_modules.network ? 1 : 0
  source = "../../modules/base-infrastructure"

  resource_group_name = module.resource_group[0].rg_name
  app_name            = var.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  dns_servers         = var.dns_servers
  create_ddos_plan    = var.create_ddos_plan
  ddos_plan_name      = var.ddos_plan_name
  subnets             = var.subnets
}

module "vnet-2" {
  count  = var.provision_modules.network ? 1 : 0
  source = "../../modules/base-infrastructure"

  resource_group_name = module.resource_group[0].rg_name
  app_name            = var.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets
}