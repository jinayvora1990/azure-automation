locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}

module "app_resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = "aks-rg-test"
  tags    = local.tags
}

module "log_analytics_workspace" {
  source              = "../../../modules/log-analytics-workspace"
  resource_group_name = module.app_resource_group.rg_name
  application_name    = "abcd"
  environment         = "dev"
}

#variable "acr_names" {
#  type        = list(string)
#  description = "ACR Names"
#  default     = ["akstest02", "akstest03"]
#}

module "aks-create" {
  source = "../../../modules/aks/create"

  aks_subnet = {
    name           = "aks-test-subnet-02"
    vnet_name      = "test-vnet"
    resource_group = "aks-test-rg"
  }

  resource_group_name                           = module.app_resource_group.rg_name
  environment                                   = "dev"
  application_name                              = "abcd"
  api_server_authorized_ip_ranges               = ["0.0.0.0/0"]
  oms_agent_log_analytics_workspace_id          = module.log_analytics_workspace.law_id
  tags                                          = local.tags
  enable_azure_key_vault_secrets_provider       = true
  azure_active_directory_admin_group_object_ids = ["77e919ac-290c-4493-b3aa-0a74aaf69ca5"]
  acr = [{
    name           = "akstest02"
    resource_group = "aks-test-rg"
    },
    {
      name           = "akstest03"
      resource_group = "aks-test-rg"
    },
  ]
  streams    = ["Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents", "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory", "Microsoft-KubePVInventory", "Microsoft-KubeServices", "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics", "Microsoft-ContainerInventory", "Microsoft-ContainerNodeInventory", "Microsoft-Perf"]
  depends_on = [module.app_resource_group]
}
