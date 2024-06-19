locals {
  sc_name = "capture-sc-1"
}

module "eventhub" {
  count  = var.provision_modules.eventhub ? 1 : 0
  source = "../../modules/eventhub"

  application_name    = var.application_name
  environment         = var.environment
  resource_group_name = module.resource_group[0].rg_name
  eventhub_config     = local.eventhub_config
}