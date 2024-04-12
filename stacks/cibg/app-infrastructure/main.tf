locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}

module "app_resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = "aks-rg"
  tags    = local.tags
}

module "base-infra" {
  source = "../../../modules/aks/create"

  aks_subnet = {
    name           = "default"
    vnet_name      = "aks-vnet-test"
    resource_group = "aks-test-rg"
  }

  resource_group_name                     = "aks-test-rg"
  environment                             = "dev"
  application_name                        = "cibg"
  api_server_authorized_ip_ranges         = ["3.7.139.138/32"]
  enable_azure_key_vault_secrets_provider = true

  tags = local.tags

  depends_on = [module.app_resource_group]
  diagnostic_settings = {
    example = {
      log_categories                           = toset(["kube-apiserver", "kube-audit", "kube-controller-manager", "kube-scheduler"])
      metric_categories                        = toset(["AllMetrics"])
      log_analytics_destination_type           = "Dedicated"
      workspace_resource_id                    = module.base-infra.log_analytics_workspace
      storage_account_resource_id              = null
      event_hub_authorization_rule_resource_id = null
      event_hub_name                           = null
      marketplace_partner_resource_id          = null
    }
  }


}
