locals {
  sc_name = "capture-sc-1"
}

module "eventhub" {
  source = "../../modules/eventhub"

  application_name    = "avd"
  environment         = "dev"
  resource_group_name = module.base_infra_resource_group.rg_name
  eventhub_config = [
    {
      name              = "topic-1"
      message_retention = 1
      partition_count   = 4
    },
    {
      name              = "topic-2"
      message_retention = 1
      partition_count   = 2
      enable_capture    = true
      capture_config = {
        encoding = "Avro"
        destination = {
          storage_account_id  = module.storage_account.storage_account_id
          blob_container_name = local.sc_name
        }
      }
    }
  ]
}

module "storage_account" {
  source               = "../../modules/storage"
  resource_group       = module.app_resource_group.rg_name
  environment          = var.environment
  location             = var.location
  application_name     = var.application_name
  storage_account_name = "trial-${module.base_infra_resource_group.rg_name}-sa"
  account_kind         = "StorageV2"
  skuname              = "Standard_LRS"
  containers_list = [
    {
      name        = local.sc_name
      access_type = "blob"
    }
  ]
}