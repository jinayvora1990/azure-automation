locals {
  REPO_OWNER = "jinayvora1990"
  REPO_NAME  = "azurerm-storage-account"
}

module "container_app_job" {
  source                     = "../../modules/container-apps"
  environment                = local.environment
  application_name           = var.application_name
  resource_group_name        = module.resource_group[0].rg_name
  replica_timeout_seconds    = 180
  log_analytics_workspace_id = module.law[0].law_id
  subnet = {
    name           = module.base-infra[0].subnet_names[2]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
  registries = {
    acr-1 = {
      name = module.registry.acr_name
      identity = {
        name           = azurerm_user_assigned_identity.acr_pull_id.name
        resource_group = module.resource_group[0].rg_name
      }
    }
  }
  ca_job_identity_names = [
    { name                = azurerm_user_assigned_identity.acr_pull_id.name
      resource_group_name = module.resource_group[0].rg_name
    },
    { name                = azurerm_user_assigned_identity.kv_identity.name
      resource_group_name = module.resource_group[0].rg_name
    },
  ]
  secrets = {
    "PAT" = {
      name = "pat"
      kv_secret = {
        name              = "pattoken"
        kv_name           = module.azure_key_vault[0].name
        kv_resource_group = module.resource_group[0].rg_name
      }
      identity = {
        name           = azurerm_user_assigned_identity.kv_identity.name
        resource_group = module.resource_group[0].rg_name
      }
    }

  }
  event_trigger_config = {
    parallelism                 = 1
    replica_completion_count    = 1
    min_executions              = 0
    max_executions              = 10
    polling_interval_in_seconds = 30
    rules = {
      name      = "github-runner"
      rule_type = "github-runner"
      metadata = {
        "githubAPIURL"              = "https://api.github.com"
        "owner"                     = local.REPO_OWNER
        "runnerScope"               = "repo"
        "repos"                     = local.REPO_NAME
        "targetWorkflowQueueLength" = 1
      }
      auth_secret       = "pat"
      trigger_parameter = "personalAccessToken"
    }
  }
  container_config = {
    name   = "github-runner"
    cpu    = 2
    memory = "4Gi"
    image  = "${module.registry.acr_name}.azurecr.io/github-actions-runner:1.0"

    env = {
      "PAT" = {
        name        = "GITHUB_PAT"
        secret_name = "pat"
      }
      "GH_URL" = {
        name  = "GH_URL"
        value = "https://github.com/${local.REPO_OWNER}/${local.REPO_NAME}"
      }
      "REG_TOKEN_URL" = {
        name  = "REGISTRATION_TOKEN_API_URL"
        value = "https://api.github.com/repos/${local.REPO_OWNER}/${local.REPO_NAME}/actions/runners/registration-token"
      }
    }
  }
  workload_profile = {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
  tags = {
    "owners"  = "jinay",
    "project" = "adcb"
  }
  depends_on = [azurerm_user_assigned_identity.acr_pull_id, azurerm_user_assigned_identity.kv_identity, module.azure_key_vault, module.registry, module.base-infra, module.dns_zone]
}

resource "azurerm_user_assigned_identity" "acr_pull_id" {
  location            = var.location
  name                = "acrPullId"
  resource_group_name = module.resource_group[0].rg_name
}

resource "azurerm_user_assigned_identity" "kv_identity" {
  location            = var.location
  name                = "kvIdentity"
  resource_group_name = module.resource_group[0].rg_name
}