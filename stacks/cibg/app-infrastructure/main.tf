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
    name           = "aks-test-subnet"
    vnet_name      = "test-vnet"
    resource_group = "aks-test-rg"
  }

  resource_group_name                           = "aks-test-rg"
  environment                                   = "dev"
  application_name                              = "cibg"
  api_server_authorized_ip_ranges               = ["3.7.139.138/32"]
  enable_azure_key_vault_secrets_provider       = true
  azure_active_directory_admin_group_object_ids = ["77e919ac-290c-4493-b3aa-0a74aaf69ca5"]

  tags = local.tags

  depends_on = [module.app_resource_group]
  acr_id     = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg/providers/Microsoft.ContainerRegistry/registries/akstest02"
}

