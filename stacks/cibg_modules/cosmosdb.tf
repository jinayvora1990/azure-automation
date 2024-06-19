module "cosmosdb" {
  count               = var.provision_modules.cosmosdb ? 1 : 0
  source              = "../../modules/cosmosdb"
  application_name    = var.application_name
  environment         = var.environment
  resource_group_name = module.resource_group[0].rg_name
  capabilities        = var.capabilities
  consistency_policy  = var.consistency_policy
  databases           = var.databases
  failover_locations  = var.failover_locations
  privatelink_subnet = {
    name           = module.base-infra[0].subnet_names[2]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
}