module "azure_key_vault" {
  source                    = "../../modules/key-vault"
  resource_group_name       = module.resource_group.rg_name
  environment               = local.environment
  application_name          = var.application_name
  enable_rbac_authorization = true
  diagnostic_settings = {
    "settings" = {
      name                           = "diag-settings"
      log_groups                     = ["allLogs"]
      metric_categories              = ["AllMetrics"]
      log_analytics_destination_type = "AzureDiagnostics"
      workspace_resource_id          = module.law.law_id
    }
  }
  role_assignments = {
    "user" = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
  }
  network_acls = {
    bypass         = "None"
    default_action = "Allow"
  }
}

data "azurerm_client_config" "current" {}