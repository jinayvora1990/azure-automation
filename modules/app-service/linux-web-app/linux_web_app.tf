module "service-plan" {
  count               = var.existing_service_plan == null ? 1 : 0
  source              = "../service-plan"
  resource_location   = local.location
  resource_group_name = local.rg
  application_name    = var.application_name
  env                 = var.env
  tags                = var.tags
  service_plan_sku    = var.service_plan_sku
  worker_count        = var.worker_count
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "linux-web-app" {
  location            = local.location
  name                = format("app-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), "-1" /*module.res-id.result*/)
  resource_group_name = local.rg
  service_plan_id     = var.existing_service_plan == null ? module.service-plan.id : data.azurerm_service_plan.existing_service_plan[0].id

  app_settings = local.app_settings

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
      for_each = concat(local.subnets, local.cidrs, local.service_tags)
      content {
        name                      = ip_restriction.value.name
        ip_address                = ip_restriction.value.ip_address
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        service_tag               = ip_restriction.value.service_tag
        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        headers                   = ip_restriction.value.headers
      }
    }

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

  https_only                    = true
  public_network_access_enabled = var.public_network_access_enabled
  # virtual_network_subnet_id     = data.azurerm_subnet.app_service_subnet.id

  tags       = merge(var.tags, local.common_tags, { "resource_type" = "linux-web-app" })
  depends_on = [module.service-plan]
}


# Custom Domain Mapping
# resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname_binding" {
#   # Check if multiple are supported?
#   hostname            = var.custom_domain.hostname
#   app_service_name    = azurerm_linux_web_app.linux-web-app.name
#   resource_group_name = local.rg
# }

# resource "azurerm_app_service_managed_certificate" "managed_certificate" {
#   # Doesn't work if the application is not publicly exposed
#   count = (var.custom_domain != null && var.custom_domain.certificate != null) ? 0 : 1
#   custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding.id
# }

# resource "azurerm_app_service_certificate" "certificate" {
#   count = (var.custom_domain !=null && var.custom_domain.certificate != null) ? 1 : 0
#   name                = "ff"
#   resource_group_name = local.rg
#   location            = local.location
#   pfx_blob            = data.azurerm_key_vault_secret.certificate.value
# }

# resource "azurerm_app_service_certificate_binding" "certificate_binding" {
#   certificate_id      = var.custom_domain.certificate !=null ? azurerm_app_service_certificate.certificate.0.id : azurerm_app_service_managed_certificate.managed_certificate.0.id
#   hostname_binding_id = azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding.id
#   ssl_state           = "SniEnabled"
# }