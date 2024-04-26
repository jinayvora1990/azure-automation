module "res-id" {
  source = "../../utility/random-identifier"
}

module "service-plan" {
  count                    = var.existing_service_plan == null ? 1 : 0
  source                   = "../app-service-plan"
  resource_location        = local.location
  resource_group_name      = local.rg
  application_name         = var.application_name
  environment              = var.environment
  service_plan_sku         = var.service_plan_sku
  max_elastic_worker_count = var.max_elastic_worker_count
  os_type                  = "Linux"
  tags                     = merge(var.tags, local.common_tags)
  #   prefix              = "app"
}

module "app-insights" {
  count               = var.application_insights_enabled ? 1 : 0
  source              = "../../monitoring/app-insights"
  resource_group_name = local.rg
  resource_location   = local.location
  application_name    = var.application_name
  environment         = var.environment
  application_type    = "web"
  tags                = merge(var.tags, local.common_tags)
  workspace_id        = var.application_insights_enabled && var.log_analytics_ws != null ? data.azurerm_log_analytics_workspace.workspace[0].id : null
}

module "storage_account" {
  source               = "../../storage"
  resource_group       = local.rg
  environment          = var.environment
  location             = local.location
  application_name     = var.application_name
  storage_account_name = format("func-sa-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  account_kind         = "StorageV2"
  skuname              = "Standard_LRS"
}

resource "azurerm_linux_function_app" "function-app" {
  location                   = local.location
  name                       = format("func-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name        = local.rg
  service_plan_id            = var.existing_service_plan == null ? module.service-plan[0].id : data.azurerm_service_plan.existing_service_plan[0].id
  storage_account_name       = module.storage_account.storage_account_name
  storage_account_access_key = module.storage_account.storage_primary_access_key

  app_settings                  = local.app_settings
  https_only                    = true
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.app_function_subnet != null ? data.azurerm_subnet.app_service_subnet[0].id : null
  functions_extension_version   = "~4"
  daily_memory_time_quota       = local.is_service_plan_consumption ? var.daily_memory_time_quota : null
  #   key_vault_reference_identity_id = ""
  #   zip_deploy_file                 = ""

  site_config {
    always_on                              = local.is_service_plan_elastic ? false : lookup(var.site_config, "always_on", null)
    app_command_line                       = lookup(var.site_config, "app_command_line", null)
    default_documents                      = lookup(var.site_config, "default_documents", null)
    ftps_state                             = lookup(var.site_config, "ftps_state", null)
    health_check_path                      = lookup(var.site_config, "health_check_path", null)
    health_check_eviction_time_in_min      = lookup(var.site_config, "health_check_eviction_time_in_min", null)
    http2_enabled                          = lookup(var.site_config, "http2", null)
    load_balancing_mode                    = lookup(var.site_config, "load_balancing_mode", null)
    application_insights_key               = var.application_insights_enabled ? try(module.app-insights.instrumentation_key, null) : null
    application_insights_connection_string = var.application_insights_enabled ? try(module.app-insights.connection_string, null) : null
    app_scale_limit                        = local.is_service_plan_elastic ? lookup(var.site_config, "app_scale_limit", null) : null
    elastic_instance_minimum               = local.is_service_plan_elastic_premium ? lookup(var.site_config, "elastic_instance_minimum", null) : null
    pre_warmed_instance_count              = local.is_service_plan_elastic_premium ? lookup(var.site_config, "pre_warmed_instance_count", null) : null

    #     container_registry_managed_identity_client_id = ""
    #     container_registry_use_managed_identity       = false
    #     managed_pipeline_mode                         = ""

    dynamic "application_stack" {
      for_each = lookup(var.site_config, "application_stack", null) == null ? [] : ["application_stack"]
      content {
        dynamic "docker" {
          for_each = lookup(application_stack, "docker", null) == null ? [] : ["docker"]
          content {
            image_name   = lookup(var.site_config.application_stack.docker, "image_name", null)
            image_tag    = lookup(var.site_config.application_stack.docker, "image_tag", null)
            registry_url = lookup(var.site_config.application_stack.docker, "registry_url", null)
          }
        }

        dotnet_version              = lookup(var.site_config.application_stack, "dotnet_version", null)
        use_dotnet_isolated_runtime = lookup(var.site_config.application_stack, "use_dotnet_isolated_runtime", null)
        java_version                = lookup(var.site_config.application_stack, "java_version", null)
        node_version                = lookup(var.site_config.application_stack, "node_version", null)
        python_version              = lookup(var.site_config.application_stack, "python_version", null)
        use_custom_runtime          = lookup(var.site_config.application_stack, "use_custom_runtime", null)
      }
    }

    dynamic "app_service_logs" {
      for_each = lookup(var.site_config, "app_service_logs", null) != null && local.is_service_plan_elastic_premium ? ["app_service_logs"] : []
      content {
        disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb", null)
        retention_period_days = lookup(app_service_logs.value, "retention_period_days", null)
      }
    }

    dynamic "ip_restriction" {
      for_each = concat(var.site_config.cidr_restriction, var.site_config.service_tags_restriction, var.site_config.subnet_restriction)
      content {
        name                      = lookup(ip_restriction.value, "name", null)
        ip_address                = lookup(ip_restriction.value, "cidr", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "subnet_id", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        priority                  = lookup(ip_restriction.value, "priority", null)
        action                    = lookup(ip_restriction.value, "action", null)
        #         headers                   = [local.default_ip_restrictions_headers]
      }
    }
    ip_restriction_default_action = var.site_config.default_ip_restriction_action

    dynamic "cors" {
      for_each = lookup(var.site_config, "cors", null) == null ? [] : ["cors"]
      content {
        allowed_origins     = lookup(var.site_config.cors, "allowed_origins", null)
        support_credentials = lookup(var.site_config.cors, "support_credentials", null)
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  dynamic "backup" {
    for_each = var.backup == null ? [] : ["backup"]
    content {
      enabled             = lookup(var.backup, "enabled", true)
      name                = "${var.application_name}-app-service-backup"
      storage_account_url = "https://${var.backup.backup_sa.name}.blob.core.windows.net/${azurerm_storage_container.backup_container[0].name}${data.azurerm_storage_account_blob_container_sas.container_sas[0].sas}"
      schedule {
        frequency_interval       = var.backup.schedule.frequency_interval
        frequency_unit           = var.backup.schedule.frequency_unit
        keep_at_least_one_backup = var.backup.schedule.keep_at_least_one_backup
        retention_period_days    = var.backup.schedule.retention_period_days
        start_time               = var.backup.schedule.start_time
      }
    }
  }

  tags       = merge(var.tags, local.common_tags, { "resource_type" = "linux-function-app" })
  depends_on = [module.storage_account, module.service-plan]
}

resource "azurerm_storage_container" "backup_container" {
  count                 = var.backup == null ? 0 : 1
  name                  = format("app-sc-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  storage_account_name  = var.backup.backup_sa.name
  container_access_type = "container"
}