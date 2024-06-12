module "law" {
  count               = var.provision_modules.law ? 1 : 0
  source              = "../../modules/log-analytics-workspace"
  application_name    = var.application_name
  environment         = var.environment
  resource_group_name = module.resource_group[0].rg_name
  tags                = local.tags
}