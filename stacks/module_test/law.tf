module "law" {
  source              = "../../modules/log-analytics-workspace"
  application_name    = var.application_name
  environment         = var.environment
  resource_group_name = module.resource_group.rg_name
  tags                = local.tags
}