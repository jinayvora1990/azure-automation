module "res-id" {
  source = "../utility/random-identifier"
}

resource "azurerm_container_app_environment" "container_app_env" {
  location                   = var.resource_location
  name                       = local.container_app_env_name
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id != null ? var.log_analytics_workspace_id : null
  infrastructure_subnet_id   = var.subnet != null ? data.azurerm_subnet.subnet[0].id : null
  dynamic "workload_profile" {
    for_each = var.workload_profile != null ? ["workload profile"] : []
    content {
      name                  = var.workload_profile.name
      workload_profile_type = var.workload_profile.workload_profile_type
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [infrastructure_subnet_id]
  }
}

resource "azurerm_container_app_job" "github_action_job" {
  name                         = local.container_app_job_name
  location                     = var.resource_location
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  replica_timeout_in_seconds   = var.replica_timeout_seconds
  replica_retry_limit          = var.replica_retry_limit

  dynamic "event_trigger_config" {
    for_each = var.event_trigger_config != null ? ["event_trigger_config"] : []
    content {
      parallelism              = var.event_trigger_config.parallelism
      replica_completion_count = var.event_trigger_config.replica_completion_count
      scale {
        min_executions              = var.event_trigger_config.min_executions
        max_executions              = var.event_trigger_config.max_executions
        polling_interval_in_seconds = var.event_trigger_config.polling_interval_in_seconds

        dynamic "rules" {
          for_each = var.event_trigger_config.rules != null ? ["rules"] : []
          content {
            name             = var.event_trigger_config.rules.name
            custom_rule_type = var.event_trigger_config.rules.rule_type
            metadata         = var.event_trigger_config.rules.metadata
            dynamic "authentication" {
              for_each = var.event_trigger_config.rules.auth_secret != null ? ["auth"] : []
              content {
                secret_name       = var.event_trigger_config.rules.auth_secret
                trigger_parameter = var.event_trigger_config.rules.trigger_parameter
              }
            }
          }
        }
      }
    }
  }

  dynamic "registry" {
    for_each = var.registries
    content {
      server   = "${registry.value.name}.azurecr.io"
      identity = data.azurerm_user_assigned_identity.registry_identity[registry.key].id
    }
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name                = secret.value.name
      key_vault_secret_id = data.azurerm_key_vault_secret.secret[secret.key].id
      identity            = data.azurerm_user_assigned_identity.kv_identity[secret.key].id
    }
  }

  dynamic "identity" {
    for_each = var.ca_job_identity_names != [] ? ["identities"] : []
    content {
      type         = "SystemAssigned, UserAssigned"
      identity_ids = data.azurerm_user_assigned_identity.ca_job_identity[*].id
    }
  }

  template {
    container {
      name   = var.container_config.name
      image  = var.container_config.image
      cpu    = var.container_config.cpu
      memory = var.container_config.memory
      dynamic "env" {
        for_each = var.container_config.env
        content {
          name        = env.value.name
          secret_name = env.value.secret_name
          value       = env.value.value
        }
      }
    }
  }

  tags = var.tags
}