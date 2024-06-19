locals {
  aks_rg = format("rg-%s-%s-%s-aks", var.application_name, local.environment, var.location)
}

module "aks_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.aks_rg
  tags    = local.tags
}


module "aks-create" {
  count  = var.provision_modules.cosmosdb ? 1 : 0
  source = "../../modules/aks/create"

  aks_subnet = {
    name           = module.base-infra[0].subnet_names[3]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
  depends_on                      = [module.base-infra]
  aks_network_plugin              = "azure"
  resource_group_name             = module.aks_resource_group.rg_name
  environment                     = local.environment
  application_name                = var.application_name
  api_server_authorized_ip_ranges = var.aks_api_server_authorized_ip_ranges
  #dapr_enabled                                  = true
  azure_active_directory_admin_group_object_ids = ["77e919ac-290c-4493-b3aa-0a74aaf69ca5"]
  oms_agent_log_analytics_workspace_id          = module.law[0].law_id
  tags                                          = local.tags

  acr = [{
    name           = module.registry.acr_name
    resource_group = module.registry.acr_rg
  }]
}