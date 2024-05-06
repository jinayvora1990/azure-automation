locals {
  rg_name = "db-dns-test"
}

module "app_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.rg_name
  tags    = local.tags
}

module "vnet" {
  source              = "../../modules/base-infrastructure"
  app_name            = var.application_name
  environment         = var.environment
  resource_group_name = module.app_resource_group.rg_name
  vnet_address_spaces = ["10.0.1.0/24"]
  subnets = {
    "subnet-1" : {
      subnet_name           = "vm-subnet"
      subnet_address_prefix = ["10.0.1.0/28"]
    }
    "subnet-2" : {
      subnet_name           = "pep-subnet"
      subnet_address_prefix = ["10.0.1.128/28"]
    }
  }
}

module "dns" {
  source         = "../../modules/dns"
  dns_zone_name  = "privatelink.redis.cache.windows.net"
  vnet_name      = module.vnet.vnet_name
  resource_group = module.app_resource_group.rg_name
  depends_on     = [module.vnet]
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
    name           = module.vnet.subnet_names[1]
    vnet_name      = module.vnet.vnet_name
    resource_group = module.app_resource_group.rg_name
  }
  private_dns_zone_name = module.dns.dns_zone_name
  depends_on            = [module.vnet, module.dns]
}