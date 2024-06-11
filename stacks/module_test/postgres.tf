module "postgres-db" {
  source           = "../../modules/postgres"
  application_name = var.application_name
  environment      = local.environment
  keyvault = {
    name                        = module.azure_key_vault.name
    resource_group              = module.resource_group.rg_name
    postgres_admin_username_key = "postgresUser"
    postgres_admin_password_key = "postgresSecret"
  }
  /*psql_subnet = {
    name           = module.base-infra.subnet_names[0]
    vnet_name      = module.base-infra.vnet_name
    resource_group = module.resource_group.rg_name
  }*/
  privatelink_subnet = {
    name           = module.base-infra.subnet_names[0]
    vnet_name      = module.base-infra.vnet_name
    resource_group = module.resource_group.rg_name
  }
  private_dns_zone_name = module.dns_zone.dns_zone_name
  resource_group_name   = module.resource_group.rg_name
  sku_name              = "GP_Standard_D2s_v3"
  sql_version           = "12"
  storage_tier          = "P15"
  depends_on            = [module.azure_key_vault]
}

