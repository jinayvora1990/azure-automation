locals {
  aks_rg = format("rg-%s-%s-%s-aks", local.application_name, local.environment, local.region_shortcode)
}

module "aks_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.aks_rg
  tags    = local.tags
}

module "aks-create" {
  source = "../../modules/aks/create"

  aks_subnet = {
    name           = var.aks_subnet_name
    vnet_name      = module.base-infra.vnet_name
    resource_group = module.base_infra_resource_group.rg_name
  }

  resource_group_name             = module.aks_resource_group.rg_name
  environment                     = local.environment
  application_name                = local.application_name
  api_server_authorized_ip_ranges = var.aks_api_server_authorized_ip_ranges

  tags = local.tags
  acr = [{
    name           = module.acr.acr_name
    resource_group = module.acr.acr_rg
  }]
}
