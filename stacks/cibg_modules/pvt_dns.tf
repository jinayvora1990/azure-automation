module "dns_zone" {
  count         = var.provision_modules.pvt_dns ? 1 : 0
  source        = "../../modules/dns"
  dns_zone_name = "privatelink.database.azure.com"
  vnet_link = {
    vnet_name         = module.base-infra[0].vnet_name
    auto_registration = false
  }
  resource_group = module.resource_group[0].rg_name
}