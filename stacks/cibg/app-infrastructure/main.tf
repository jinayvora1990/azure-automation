locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
  rg_name = "app-svc-test"
}

module "app_resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = local.rg_name
  tags    = local.tags
}

module "base-infra" {
  source = "../../../modules/app-service/service-plan"

  resource_group_name = local.rg_name
  application_name    = "cibg"
  worker_count        = 1

  depends_on = [module.app_resource_group]
}

module "base-infra-svc-plan" {
  source = "../../../modules/app-service/linux-web-app"

  resource_group_name = local.rg_name
  application_name    = "cibg"

  #   existing_service_plan = {
  #     name                = module.base-infra.name
  #     resource_group_name = local.rg_name
  #   }

  site_config = {
    application_stack = {
      "go_version" = "1.18"
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

  custom_domain = {
    hostname = "www.example.com"
    certificate = {
      name = "abc"
      vault = {
        name           = "gfsd"
        resource_group = local.rg_name
      }
    }
  }

  depends_on = [module.base-infra]
}