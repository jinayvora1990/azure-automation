locals {
  app_svc_rg = format("rg-%s-%s-%s-appsvc", local.application_name, local.environment, local.region_shortcode)
}

module "app_resource_group" {
  source = "../../modules/resource-groups"

  rg_name = local.app_svc_rg
  tags    = local.tags
}

module "app_service_environment" {
  source = "../../modules/app-service/app-service-environment"

  resource_group_name = module.app_resource_group.rg_name
  application_name    = local.application_name
  environment         = local.environment

  ase_subnet = {
    name           = var.ase_subnet_name
    vnet_name      = module.base-infra.vnet_name
    resource_group = module.base_infra_resource_group.rg_name
  }

  cluster_setting = var.ase_cluster_setting
  tags            = local.tags
}

module "app_svc_plan" {
  source = "../../modules/app-service/app-service-plan"

  resource_group_name = module.app_resource_group.rg_name
  application_name    = local.application_name
  environment         = local.environment

  tags = local.tags
}