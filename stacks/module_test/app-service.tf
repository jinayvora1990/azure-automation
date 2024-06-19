locals {
  app_svc_rg = format("rg-%s-%s-%s-appsvc", var.application_name, local.environment, var.location)
}

module "app_resource_group" {
  source = "../../modules/resource-groups"

  rg_name = local.app_svc_rg
  tags    = local.tags
}

module "app_service_environment" {
  source = "../../modules/app-service/app-service-environment"

  resource_group_name = module.app_resource_group.rg_name
  application_name    = var.application_name
  environment         = local.environment

  ase_subnet = {
    name           = module.base-infra[0].subnet_names[4]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }

  cluster_setting = var.ase_cluster_setting
  tags            = local.tags
}

module "app_svc_plan" {
  source = "../../modules/app-service/app-service-plan"

  resource_group_name = module.app_resource_group.rg_name
  application_name    = var.application_name
  environment         = local.environment

  tags = local.tags
}