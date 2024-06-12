locals {
  sc_name = "capture-sc-1"
}

module "eventhub" {
  source = "../../modules/eventhub"

  application_name    = "avd"
  environment         = "dev"
  resource_group_name = module.resource_group.rg_name
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