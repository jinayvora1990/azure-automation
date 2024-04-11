locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}

module "app_resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = "app-svc-test"
  tags    = local.tags
}

module "base-infra" {
  source = "../../../modules/app-service/service-plan"

  resource_group_name = "app-svc-test"
  application_name    = "cibg"
  worker_count        = 1

  depends_on = [module.app_resource_group]
}

module "base-infra-svc-plan" {
  source = "../../../modules/app-service/linux-web-app"

  resource_group_name = "app-svc-test"
  application_name    = "cibg"

  existing_service_plan = {
    name                = module.base-infra.name
    resource_group_name = "app-svc-test"
  }

  site_config = {}

  depends_on = [module.base-infra]
}