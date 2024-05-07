locals {
  rg_name = "redis-dns"
}

module "redis_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.rg_name
  tags    = local.tags
}

module "redis-dns" {
  source         = "../../modules/dns"
  dns_zone_name  = "privatelink.redis.cache.windows.net"
  vnet_name      = module.base-infra.vnet_name
  resource_group = module.app_resource_group.rg_name
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
    name           = module.base-infra.subnet_names[1]
    vnet_name      = module.base-infra.vnet_name
    resource_group = module.app_resource_group.rg_name
  }
  private_dns_zone_name = module.redis-dns.dns_zone_name
}