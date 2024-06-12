module "storage_account" {
  source               = "../../modules/storage"
  resource_group       = module.resource_group.rg_name
  environment          = var.environment
  location             = var.location
  application_name     = var.application_name
  storage_account_name = "trial-${module.resource_group.rg_name}-sa"
  account_kind         = "StorageV2"
  skuname              = "Standard_LRS"
  containers_list = [
    {
      name        = local.sc_name
      access_type = "blob"
    }
  ]
}