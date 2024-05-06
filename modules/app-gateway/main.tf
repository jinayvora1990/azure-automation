resource "azurerm_public_ip" "app_gateway_ip" {
  name                    = format("agwip-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), "1")
  resource_group_name     = var.resource_group_name
  location                = local.location
  sku                     = var.ip_sku
  allocation_method       = var.ip_allocation_method
  domain_name_label       = var.ip_label
  ddos_protection_mode    = var.ip_ddos_protection_mode
  ddos_protection_plan_id = var.ip_ddos_protection_plan_id
  zones                   = ["1", "2", "3"]
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = format("agw-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, local.location, substr(var.resource_location, 0, 4)), "1")
  resource_group_name = var.resource_group_name
  location            = local.location
  zones               = ["1", "2", "3"]

  enable_http2       = var.enable_http2
  firewall_policy_id = var.firewall_policy_id

  sku {
    capacity = var.autoscaling_parameters != null ? null : var.sku_capacity
    name     = var.sku
    tier     = var.sku
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscaling_parameters != null ? ["enabled"] : []
    content {
      min_capacity = var.autoscaling_parameters.min_capacity
      max_capacity = var.autoscaling_parameters.max_capacity
    }
  }

  gateway_ip_configuration {
    name      = "app-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgw_subnet.id
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway_ip.id
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port_settings
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  force_firewall_policy_association = var.force_firewall_policy_association

  dynamic "waf_configuration" {
    for_each = var.sku == "WAF_v2" && var.waf_configuration != null ? [var.waf_configuration] : []
    content {
      enabled                  = waf_configuration.value.enabled
      file_upload_limit_mb     = waf_configuration.value.file_upload_limit_mb
      firewall_mode            = waf_configuration.value.firewall_mode
      max_request_body_size_kb = waf_configuration.value.max_request_body_size_kb
      request_body_check       = waf_configuration.value.request_body_check
      rule_set_type            = waf_configuration.value.rule_set_type
      rule_set_version         = waf_configuration.value.rule_set_version

      dynamic "disabled_rule_group" {
        for_each = local.disabled_rule_group_settings != null ? local.disabled_rule_group_settings : []
        content {
          rule_group_name = disabled_rule_group.value.rule_group_name
          rules           = disabled_rule_group.value.rules
        }
      }

      dynamic "exclusion" {
        for_each = waf_configuration.value.exclusion != null ? waf_configuration.value.exclusion : []
        content {
          match_variable          = exclusion.value.match_variable
          selector                = exclusion.value.selector
          selector_match_operator = exclusion.value.selector_match_operator
        }
      }
    }
  }

  dynamic "ssl_policy" {
    for_each = var.ssl_policy == null ? [] : ["enabled"]
    content {
      disabled_protocols   = var.ssl_policy.disabled_protocols
      policy_type          = var.ssl_policy.policy_type
      policy_name          = var.ssl_policy.policy_type == "Predefined" ? var.ssl_policy.policy_name : null
      cipher_suites        = var.ssl_policy.policy_type == "Custom" ? var.ssl_policy.cipher_suites : null
      min_protocol_version = var.ssl_policy.policy_type == "Custom" ? var.ssl_policy.min_protocol_version : null
    }
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profile

    content {
      name                             = ssl_profile.value.name
      trusted_client_certificate_names = ssl_profile.value.trusted_client_certificate_names
      verify_client_cert_issuer_dn     = ssl_profile.value.verify_client_cert_issuer_dn
      dynamic "ssl_policy" {
        for_each = ssl_profile.value.ssl_policy == null ? [] : ["enabled"]
        content {
          disabled_protocols   = ssl_profile.value.ssl_policy.disabled_protocols
          policy_type          = ssl_profile.value.ssl_policy.policy_type
          policy_name          = ssl_profile.value.ssl_policy.policy_type == "Predefined" ? ssl_profile.value.ssl_policy.policy_name : null
          cipher_suites        = strcontains(ssl_profile.value.ssl_policy.policy_type, "Custom") ? ssl_profile.value.ssl_policy.cipher_suites : null
          min_protocol_version = strcontains(ssl_profile.value.ssl_policy.policy_type, "Custom") ? ssl_profile.value.ssl_policy.min_protocol_version : null
        }
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates_configs
    iterator = ssl_crt
    content {
      name                = ssl_crt.value.name
      data                = ssl_crt.value.data
      password            = ssl_crt.value.password
      key_vault_secret_id = ssl_crt.value.key_vault_secret_id
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate_configs
    iterator = ssl_crt
    content {
      name                = ssl_crt.value.name
      data                = ssl_crt.value.data == null ? try(filebase64(ssl_crt.value.file_path), null) : ssl_crt.value.data
      key_vault_secret_id = ssl_crt.value.key_vault_secret_id
    }
  }

  dynamic "http_listener" {
    for_each = var.appgw_http_listeners
    iterator = http_listen
    content {
      name                           = http_listen.value.name
      frontend_ip_configuration_name = coalesce(http_listen.value.frontend_ip_configuration_name, var.appgw_private ? local.frontend_priv_ip_configuration_name : local.frontend_ip_configuration_name)
      frontend_port_name             = http_listen.value.frontend_port_name
      host_name                      = http_listen.value.host_name
      host_names                     = http_listen.value.host_names
      protocol                       = http_listen.value.protocol
      require_sni                    = http_listen.value.require_sni
      ssl_certificate_name           = http_listen.value.ssl_certificate_name
      ssl_profile_name               = http_listen.value.ssl_profile_name
      firewall_policy_id             = http_listen.value.firewall_policy_id
      dynamic "custom_error_configuration" {
        for_each = http_listen.value.custom_error_configuration
        iterator = err_conf
        content {
          status_code           = err_conf.value.status_code
          custom_error_page_url = err_conf.value.custom_error_page_url
        }
      }
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.appgw_backend_http_settings
    iterator = back_http_set
    content {
      name     = back_http_set.value.name
      port     = back_http_set.value.port
      protocol = back_http_set.value.protocol

      path       = back_http_set.value.path
      probe_name = back_http_set.value.probe_name

      cookie_based_affinity               = back_http_set.value.cookie_based_affinity
      affinity_cookie_name                = back_http_set.value.affinity_cookie_name
      request_timeout                     = back_http_set.value.request_timeout
      host_name                           = back_http_set.value.host_name
      pick_host_name_from_backend_address = back_http_set.value.pick_host_name_from_backend_address
      trusted_root_certificate_names      = back_http_set.value.trusted_root_certificate_names

      dynamic "authentication_certificate" {
        for_each = back_http_set.value.authentication_certificate != null ? ["enabled"] : []
        content {
          name = back_http_set.value.authentication_certificate
        }
      }

      dynamic "connection_draining" {
        for_each = back_http_set.value.connection_draining_timeout_sec != null ? ["enabled"] : []
        content {
          enabled           = true
          drain_timeout_sec = back_http_set.value.connection_draining_timeout_sec
        }
      }
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_backend_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "probe" {
    for_each = var.appgw_probes
    content {
      name = probe.value.name

      host     = probe.value.host
      port     = probe.value.port
      interval = probe.value.interval

      path     = probe.value.path
      protocol = probe.value.protocol
      timeout  = probe.value.timeout

      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      minimum_servers                           = probe.value.minimum_servers
      match {
        body        = probe.value.match.body
        status_code = probe.value.match.status_code
      }
    }
  }

  dynamic "url_path_map" {
    for_each = var.appgw_url_path_map
    content {
      name                                = url_path_map.value.name
      default_redirect_configuration_name = url_path_map.value.default_backend_address_pool_name == null && url_path_map.value.default_backend_http_settings_name == null ? url_path_map.value.default_redirect_configuration_name : null
      default_backend_address_pool_name   = url_path_map.value.default_redirect_configuration_name == null ? url_path_map.value.default_backend_address_pool_name : null
      default_backend_http_settings_name  = url_path_map.value.default_redirect_configuration_name == null ? coalesce(url_path_map.value.default_backend_http_settings_name, url_path_map.value.default_backend_address_pool_name) : null
      default_rewrite_rule_set_name       = url_path_map.value.default_rewrite_rule_set_name

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                        = path_rule.value.name
          backend_address_pool_name   = path_rule.value.redirect_configuration_name == null ? coalesce(path_rule.value.backend_address_pool_name, path_rule.value.name) : null
          backend_http_settings_name  = path_rule.value.redirect_configuration_name == null ? coalesce(path_rule.value.backend_http_settings_name, path_rule.value.name) : null
          rewrite_rule_set_name       = path_rule.value.rewrite_rule_set_name
          redirect_configuration_name = path_rule.value.redirect_configuration_name
          paths                       = path_rule.value.paths
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.appgw_redirect_configuration
    iterator = redirect
    content {
      name                 = redirect.value.name
      redirect_type        = redirect.value.redirect_type
      target_listener_name = redirect.value.target_listener_name
      target_url           = redirect.value.target_url
      include_path         = redirect.value.include_path
      include_query_string = redirect.value.include_query_string
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.appgw_routings
    iterator = routing
    content {
      name      = routing.value.name
      rule_type = routing.value.rule_type

      http_listener_name          = coalesce(routing.value.http_listener_name, routing.value.name)
      backend_address_pool_name   = routing.value.backend_address_pool_name
      backend_http_settings_name  = routing.value.backend_http_settings_name
      url_path_map_name           = routing.value.url_path_map_name
      redirect_configuration_name = routing.value.redirect_configuration_name
      rewrite_rule_set_name       = routing.value.rewrite_rule_set_name
      priority                    = coalesce(routing.value.priority, routing.key + 1)
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.appgw_rewrite_rule_set
    content {
      name = rewrite_rule_set.value.name

      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rules
        iterator = rule
        content {
          name          = rule.value.name
          rule_sequence = rule.value.rule_sequence

          dynamic "condition" {
            for_each = rule.value.conditions
            iterator = cond
            content {
              variable    = cond.value.variable
              pattern     = cond.value.pattern
              ignore_case = cond.value.ignore_case
              negate      = cond.value.negate
            }
          }

          dynamic "response_header_configuration" {
            for_each = rule.value.response_header_configurations
            iterator = header
            content {
              header_name  = header.value.header_name
              header_value = header.value.header_value
            }
          }

          dynamic "request_header_configuration" {
            for_each = rule.value.request_header_configurations
            iterator = header
            content {
              header_name  = header.value.header_name
              header_value = header.value.header_value
            }
          }

          dynamic "url" {
            for_each = rule.value.url_reroute != null ? ["enabled"] : []
            content {
              path         = rule.value.url_reroute.path
              query_string = rule.value.url_reroute.query_string
              components   = rule.value.url_reroute.components
              reroute      = rule.value.url_reroute.reroute
            }
          }
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = var.custom_error_configuration
    iterator = err_conf
    content {
      status_code           = err_conf.value.status_code
      custom_error_page_url = err_conf.value.custom_error_page_url
    }
  }

  tags = merge(var.tags, local.common_tags)
}