module "service-plan" {
  count               = var.existing_service_plan ? 0 : 1
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
  name                = format("app-%s-%s-%s-%s", var.application_name, var.env, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), "-1"/*module.res-id.result*/)
  resource_group_name = local.rg
  service_plan_id     = var.existing_service_plan ? data.azurerm_service_plan.existing_service_plan.0.id : module.service-plan.id
  app_settings        = merge(var.env_vars, {
    "WEBSITE_RUN_FROM_PACKAGE" = var.artifact_url
  })

  site_config {
    always_on = false # Need to change based on the sku
    health_check_path                 = var.health_check.path
    health_check_eviction_time_in_min = var.health_check.eviction_time
    load_balancing_mode               = var.load_balancing_mode
    worker_count                      = var.worker_count

    dynamic "application_stack" {
      for_each = var.application_stack != null ? [1] : []
      content {
        docker_image_name        = lookup(var.application_stack, "docker_image", null)
        docker_registry_url      = lookup(var.application_stack, "docker_registry_url", null)
        docker_registry_username = lookup(var.application_stack, "docker_registry_username", null)
        docker_registry_password = lookup(var.application_stack, "docker_registry_password", null)

        dotnet_version      = lookup(var.application_stack, "dotnet_version", null)
        go_version          = lookup(var.application_stack, "go_version", null)
        java_server         = lookup(var.application_stack, "java_server", null)
        java_server_version = lookup(var.application_stack, "java_server_version", null)
        java_version        = lookup(var.application_stack, "java_version", null)
        node_version        = lookup(var.application_stack, "node_version", null)
        php_version         = lookup(var.application_stack, "php_version", null)
        python_version      = lookup(var.application_stack, "python_version", null)
        ruby_version        = lookup(var.application_stack, "ruby_version", null)
      }
    }

    ip_restriction_default_action = var.ip_restriction.default_action
    dynamic "ip_restriction" {
      for_each = var.ip_restriction.rules != null ? var.ip_restriction.rules : []
      content {
        action                    = ip_restriction.value.action
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        ip_address                = ip_restriction.value.ip_address
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id

        dynamic "headers" {
          for_each = ip_restriction.value.headers != null ? ip_restriction.value.headers : []
          content {
            x_azure_fdid      = headers.value.x_azure_fdid
            x_fd_health_probe = headers.value.x_fd_health_probe
            x_forwarded_for   = headers.value.x_forwarded_for
            x_forwarded_host  = headers.value.x_forwarded_host
          }
        }
      }
    }

    dynamic "cors" {
      for_each = var.cors != null ? [1] : []
      content {
        allowed_origins     = var.cors.allowed_origins
        support_credentials = var.cors.support_credentials
      }
    }
  }

  #Optional

  client_certificate_enabled    = true
  https_only                    = true
  public_network_access_enabled = var.public_access
  virtual_network_subnet_id     = data.azurerm_subnet.app_service_subnet.id

  tags       = merge(var.tags, local.common_tags, { "resource_type" = "linux-web-app" })
  depends_on = [module.service-plan]
}


# Custom Domain Mapping
resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname_binding" {
  # Check if multiple are supported?
  hostname            = var.custom_domain.hostname
  app_service_name    = azurerm_linux_web_app.linux-web-app.name
  resource_group_name = local.rg
}

resource "azurerm_app_service_managed_certificate" "managed_certificate" {
  # Doesn't work if the application is not publicly exposed
  count = (var.custom_domain != null && var.custom_domain.certificate != null) ? 0 : 1
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding.id
}

resource "azurerm_app_service_certificate" "certificate" {
  count = (var.custom_domain !=null && var.custom_domain.certificate != null) ? 1 : 0
  name                = "ff"
  resource_group_name = local.rg
  location            = local.location
  pfx_blob            = data.azurerm_key_vault_secret.certificate.value
}

resource "azurerm_app_service_certificate_binding" "certificate_binding" {
  certificate_id      = var.custom_domain.certificate !=null ? azurerm_app_service_certificate.certificate.0.id : azurerm_app_service_managed_certificate.managed_certificate.0.id
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding.id
  ssl_state           = "SniEnabled"
}