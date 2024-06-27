module "registry" {
  source              = "../../modules/container-registry"
  application_name    = var.application_name
  environment         = local.environment
  resource_group_name = module.resource_group[0].rg_name
  kv_name             = module.azure_key_vault[0].name
  sku                 = var.acr_sku
  privatelink_subnet = {
    name           = module.base-infra[0].subnet_names[1]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
  admin_enabled                 = true
  images_retention_enabled      = true
  images_retention_days         = 30
  azure_services_bypass_allowed = true
  private_dns_zone_id           = module.dns_zone_acr.dns_zone_id
  role_assignments = {
    "container_job_id" = {
      role_definition_id_or_name = "AcrPull"
      principal_id               = azurerm_user_assigned_identity.acr_pull_id.principal_id
    }
  }
  depends_on = [module.base-infra]
}

module "dns_zone_acr" {
  source         = "../../modules/dns"
  dns_zone_name  = "privatelink.azurecr.io"
  resource_group = module.resource_group[0].rg_name
  vnet_link = {
    vnet_name         = module.base-infra[0].vnet_name
    auto_registration = false
  }
}