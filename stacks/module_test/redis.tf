locals {
  redis_rg_name = format("rg-%s-%s-%s-redis", var.application_name, local.environment, var.location)
}

module "redis_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.redis_rg_name
  tags    = local.tags
}

module "redis-dns" {
  source        = "../../modules/dns"
  dns_zone_name = "privatelink.redis.cache.windows.net"
  #vnet_name      = module.base-infra[0].vnet_name
  resource_group = module.app_resource_group.rg_name
  vnet_link = {
    vnet_name         = module.base-infra[0].vnet_name
    auto_registration = false
  }
}

module "redis" {
  source = "../../modules/redis-cache"

  cache_tier = {
    family   = "C"
    capacity = 0
    sku_name = "Basic"
  }
  resource_group_name = module.app_resource_group.rg_name
  application_name    = var.application_name
  privatelink_subnet = {
    name           = module.base-infra[0].subnet_names[1]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.app_resource_group.rg_name
  }
  private_dns_zone_name = module.redis-dns.dns_zone_name
}