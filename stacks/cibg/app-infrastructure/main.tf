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

  resource_group_name                     = "aks-rg"
  environment                             = "dev"
  application_name                        = "cibg"
  api_server_authorized_ip_ranges         = ["3.7.139.138/32"]
  enable_azure_key_vault_secrets_provider = true

  tags = local.tags

  depends_on = [module.app_resource_group]
}
