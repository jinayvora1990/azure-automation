
module "registry" {
  source                        = "../../modules/container-registry"
  application_name              = var.application_name
  environment                   = local.environment
  resource_group_name           = module.resource_group[0].rg_name
  kv_name                       = module.azure_key_vault[0].name
  sku                           = var.acr_sku
  images_retention_enabled      = true
  images_retention_days         = 30
  azure_services_bypass_allowed = true
}