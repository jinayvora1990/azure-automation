module "storage_account" {
  count                             = var.provision_modules.storage_account ? 1 : 0
  source                            = "../../modules/storage"
  resource_group                    = module.resource_group[0].rg_name
  environment                       = var.environment
  location                          = var.location
  application_name                  = var.application_name
  storage_account_name              = "trial-${module.resource_group[0].rg_name}-sa"
  account_kind                      = "StorageV2"
  skuname                           = "Standard_LRS"
  enable_advanced_threat_protection = true
  enable_versioning                 = true
  blob_soft_delete_retention_days   = 10
  containers_list = [
    {
      name        = local.sc_name
      access_type = "blob"
    }
  ]
  file_shares = [
    {
      name  = "gfs1"
      quota = 2
    }
  ]
  queues                = ["filequeue"]
  managed_identity_type = "UserAssigned"
  managed_identity_ids  = [azurerm_user_assigned_identity.uami[0].id]
  lifecycles = [
    {
      prefix_match               = ["${local.sc_name}/prefix"]
      tier_to_cool_after_days    = 10
      tier_to_archive_after_days = 15
      delete_after_days          = 30
      snapshot_delete_after_days = 20
    }
  ]
  tags = local.tags
}

resource "azurerm_user_assigned_identity" "uami" {
  count               = var.provision_modules.storage_account ? 1 : 0
  location            = var.location
  name                = "uami"
  resource_group_name = module.resource_group[0].rg_name
}