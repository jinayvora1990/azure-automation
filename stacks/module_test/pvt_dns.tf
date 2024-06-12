module "dns_zone" {
  source        = "../../modules/dns"
  dns_zone_name = "privatelink.database.azure.com"
  #   vnet_name      = module.base-infra.vnet_name
  resource_group = module.resource_group.rg_name
}