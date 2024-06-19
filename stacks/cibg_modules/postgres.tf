module "postgres-db" {
  count            = var.provision_modules.postgres ? 1 : 0
  source           = "../../modules/postgres"
  application_name = var.application_name
  environment      = local.environment
  keyvault = {
    name                        = module.azure_key_vault[0].name
    resource_group              = module.resource_group[0].rg_name
    postgres_admin_username_key = "postgresUser"
    postgres_admin_password_key = "postgresSecret"
  }
  psql_subnet = {
    name           = module.base-infra[0].subnet_names[0]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
  privatelink_subnet = {
    name           = module.base-infra[0].subnet_names[0]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
  #   private_dns_zone_name = module.dns_zone.dns_zone_name
  resource_group_name = module.resource_group[0].rg_name
  sku_name            = var.postgres_sku_name
  sql_version         = var.sql_version
  storage_tier        = var.storage_tier
  depends_on          = [module.azure_key_vault]
}

