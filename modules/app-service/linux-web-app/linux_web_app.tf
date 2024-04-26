module "res-id" {
  source = "../../utility/random-identifier"
}

module "service-plan" {
  count               = var.existing_service_plan == null ? 1 : 0
  source              = "../app-service-plan"
  resource_location   = local.location
  resource_group_name = local.rg
  application_name    = var.application_name
  environment         = var.environment
  tags                = merge(var.tags, local.common_tags)
  service_plan_sku    = var.service_plan_sku
  worker_count        = var.worker_count
  os_type             = "Linux"
  #   prefix              = "app"
}

module "app-insights" {
  count               = var.application_insights.enabled ? 1 : 0
  source              = "../../monitoring/app-insights"
  resource_group_name = local.rg
  resource_location   = local.location
  application_name    = var.application_name
  environment         = var.environment
  application_type    = "web"
  tags                = merge(var.tags, local.common_tags)
  workspace_id        = var.application_insights.enabled ? data.azurerm_log_analytics_workspace.workspace[0].id : null
}

resource "azurerm_linux_web_app" "linux-web-app" {
  location            = local.location
  name                = format("app-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name = local.rg
  service_plan_id     = var.existing_service_plan == null ? module.service-plan[0].id : data.azurerm_service_plan.existing_service_plan[0].id

  app_settings                  = local.app_settings
  https_only                    = true
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.web_app_subnet != null ? data.azurerm_subnet.app_service_subnet[0].id : null

  site_config {
    always_on                         = lookup(var.site_config, "always_on", null)
    app_command_line                  = lookup(var.site_config, "app_command_line", null)
    default_documents                 = lookup(var.site_config, "default_documents", null)
    ftps_state                        = lookup(var.site_config, "ftps_state", null)
    health_check_path                 = lookup(var.site_config, "health_check_path", null)
    health_check_eviction_time_in_min = lookup(var.site_config, "health_check_eviction_time_in_min", null)
    http2_enabled                     = lookup(var.site_config, "http2", null)
    load_balancing_mode               = lookup(var.site_config, "load_balacing_mode", null)
    worker_count                      = var.worker_count

    dynamic "application_stack" {
      for_each = lookup(var.site_config, "application_stack", null) == null ? [] : ["application_stack"]
      content {
        docker_image_name        = lookup(var.site_config.application_stack, "docker_image", null)
        docker_registry_url      = lookup(var.site_config.application_stack, "docker_registry_url", null)
        docker_registry_username = lookup(var.site_config.application_stack, "docker_registry_username", null)
        docker_registry_password = lookup(var.site_config.application_stack, "docker_registry_password", null)

        dotnet_version      = lookup(var.site_config.application_stack, "dotnet_version", null)
        go_version          = lookup(var.site_config.application_stack, "go_version", null)
        java_server         = lookup(var.site_config.application_stack, "java_server", null)
        java_server_version = lookup(var.site_config.application_stack, "java_server_version", null)
        java_version        = lookup(var.site_config.application_stack, "java_version", null)
        node_version        = lookup(var.site_config.application_stack, "node_version", null)
        php_version         = lookup(var.site_config.application_stack, "php_version", null)
        python_version      = lookup(var.site_config.application_stack, "python_version", null)
        ruby_version        = lookup(var.site_config.application_stack, "ruby_version", null)
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

  dynamic "logs" {
    for_each = var.logs == null ? [] : ["logs"]
    content {
      application_logs {
        file_system_level = var.logs.application_logs.file_system_level
        # Only available for .NET apps
        #       azure_blob_storage {
        #         level             = ""
        #         retention_in_days = 0
        #         sas_url           = ""
        #       }
      }
      # Only available for Windows platforms
      #     http_logs {}
      #     detailed_error_messages = false
      #     failed_request_tracing = false

    }
  }
  tags       = merge(var.tags, local.common_tags, { "resource_type" = "linux-web-app" })
  depends_on = [module.service-plan]
}

resource "azurerm_storage_container" "backup_container" {
  count                 = var.backup == null ? 0 : 1
  name                  = format("app-sc-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  storage_account_name  = var.backup.backup_sa.name
  container_access_type = "container"
}

# Custom Domain Mapping
resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname_binding" {
  # Check if multiple are supported?
  count               = var.custom_domain != null ? 1 : 0
  hostname            = var.custom_domain.hostname
  app_service_name    = azurerm_linux_web_app.linux-web-app.name
  resource_group_name = local.rg
}

resource "azurerm_app_service_certificate" "certificate" {
  count               = var.custom_domain != null ? 1 : 0
  name                = format("app-sslcert-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), module.res-id.result)
  resource_group_name = local.rg
  location            = local.location
  pfx_blob            = data.azurerm_key_vault_secret.certificate[0].value
  tags                = merge(var.tags, local.common_tags, { "resource_type" = "ssl-certificate" })
}

resource "azurerm_app_service_certificate_binding" "certificate_binding" {
  count               = var.custom_domain != null ? 1 : 0
  certificate_id      = azurerm_app_service_certificate.certificate[0].id
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding[0].id
  ssl_state           = "SniEnabled"
  depends_on = [
    azurerm_app_service_certificate.certificate
  ]
}