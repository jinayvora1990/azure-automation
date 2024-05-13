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

module "email_action_group" {
  source              = "../../modules/alerting/action-group"
  resource_group_name = module.app_resource_group.rg_name
  action_groups = {
    action_1 = {
      email_receiver = {
        email_receiver_1 = {
          email_address = "naman.kaushik@thoughtworks.com"
        }
        email_receiver_2 = {
          email_address = "namankaushik0712@gmail.com"
        }
      }
    }
  }
}

module "metric_alert" {
  source              = "../../modules/alerting/alerts/metric-alert"
  resource_group_name = module.app_resource_group.rg_name
  metric_alerts = {
    read = {
      scopes = [module.redis.id]
      criteria = [{
        metric_name      = "allcacheRead"
        metric_namespace = "Microsoft.Cache/redis"
        aggregation      = "Total"
        operator         = "GreaterThan"
        threshold        = 60
      }, ]
      actions = module.email_action_group.id
    },
  }
}

module "activity_log_alert" {
  source              = "../../modules/alerting/alerts/activity-log-alert"
  resource_group_name = module.app_resource_group.rg_name
  resource_location   = "global"
  activity_log_alert = {
    service = {
      scopes = [module.redis.id]
      criteria = {
        category = "Administrative"
        levels   = ["Critical", "Error"]
      }
      actions = module.email_action_group.id
    }
  }
}