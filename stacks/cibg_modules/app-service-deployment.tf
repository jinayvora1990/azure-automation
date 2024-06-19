locals {
  app_svc_rg_deployment = format("rg-%s-%s-%s-appsvcdeploy", var.application_name, local.environment, var.location)
}

module "app_service_rg" {
  source = "../../modules/resource-groups"

  rg_name = local.app_svc_rg_deployment
  tags    = local.tags
}

module "base-infra-svc-plan" {
  source = "../../modules/app-service/linux-web-app"

  resource_group_name = local.app_svc_rg_deployment
  application_name    = var.application_name
  site_config         = var.site_config

  app_slots   = false
  depends_on  = [module.app_resource_group]
  environment = var.environment
}