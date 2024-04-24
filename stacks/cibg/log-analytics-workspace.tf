locals {
  law_rg = format("rg-%s-%s-%s-law", local.application_name, local.environment, local.region_shortcode)
}

module "law_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.law_rg
  tags    = local.tags
}

module "log_analytics" {
  source = "../../modules/log-analytics-workspace"

  resource_group_name = module.law_resource_group.rg_name
  sku                 = var.log_analytics_ws_sku
  application_name    = local.application_name
  environment         = local.environment
}