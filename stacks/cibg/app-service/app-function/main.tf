locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
  rg_name = "app-svc-test"
}

module "app_resource_group" {
  source = "../../../../modules/resource-groups"

  rg_name = local.rg_name
  tags    = local.tags
}

module "base-infra-svc-plan" {
  source = "../../../../modules/app-service/app-function"

  resource_group_name = local.rg_name
  application_name    = "cibg"

  site_config = {
#     application_stack = {
#       go_version = "1.18"
#     }

  }

  backup = {
    backup_sa = {
      name           = "asd"
      resource_group = local.rg_name
    }
    schedule = {
      frequency_interval    = 5
      frequency_unit        = "Day"
      retention_period_days = 90
    }
  }

  application_insights_enabled = false
  depends_on = [module.app_resource_group]
}