module "azure_key_vault" {
  source = "../../modules/key-vault"

  resource_group_name = module.resource_group.rg_name
  environment         = local.environment
  application_name    = var.application_name
  diagnostic_settings = {
    "settings" = {
      name                           = "diag-settings"
      log_groups                     = ["allLogs"]
      metric_categories              = ["AllMetrics"]
      log_analytics_destination_type = "AzureDiagnostics"
      workspace_resource_id          = module.law.law_id
    }
  }
}
