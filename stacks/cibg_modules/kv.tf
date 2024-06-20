module "azure_key_vault" {
  count                         = var.provision_modules.kv ? 1 : 0
  source                        = "../../modules/key-vault"
  resource_group_name           = module.resource_group[0].rg_name
  environment                   = local.environment
  application_name              = var.application_name
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  /*  diagnostic_settings = {
    "settings" = {
      name                           = "diag-settings"
      log_groups                     = ["allLogs"]
      metric_categories              = ["AllMetrics"]
      log_analytics_destination_type = "AzureDiagnostics"
      workspace_resource_id          = module.law[0].law_id
    }
  }*/
  role_assignments = {
    "user" = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
    "container_job_id" = {
      role_definition_id_or_name = "Key Vault Secrets User"
      principal_id               = azurerm_user_assigned_identity.kv_identity.principal_id
    }
  }
  network_acls = {
    bypass         = "None"
    default_action = "Allow"
  }
}
