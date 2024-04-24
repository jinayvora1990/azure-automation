locals {
  kv_rg = format("rg-%s-%s-%s-kv", local.application_name, local.environment, local.region_shortcode)
}

module "kv_resource_group" {
  source = "../../modules/resource-groups"

  rg_name = local.kv_rg
  tags    = local.tags
}


module "azure_key_vault" {
  source = "../../modules/key-vault"

  resource_group_name = module.kv_resource_group.rg_name
  environment         = local.environment
  application_name    = local.application_name
}