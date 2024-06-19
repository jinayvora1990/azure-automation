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

module "base-infra-svc-prod-plan" {
  source = "../../modules/app-service/linux-web-app"

  resource_group_name = local.app_svc_rg_deployment
  application_name    = var.application_name
  service_plan_sku    = "S1"

  site_config = {
    application_stack = {
      "python_version" = "3.10"
    }
    cidr_restriction = [
      {
        name     = "demo_restriction"
        priority = 100
        action   = "Allow"
        cidr     = "10.0.0.0/24"
      },
      {
        name     = "demo_restriction_2"
        priority = 102
        action   = "Deny"
        cidr     = "10.0.0.0/26"
      },
    ]
    cors = {
      allowed_origins = ["www.jdsakl.com"]
    }
  }
  app_slots = true

  depends_on  = [module.app_resource_group]
  environment = "prod"
}