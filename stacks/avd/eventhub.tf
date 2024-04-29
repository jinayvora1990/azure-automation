locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
  rg_name = "app-svc-test"
}

module "app_resource_group" {
  source = "../../modules/resource-groups"

  rg_name = local.rg_name
  tags    = local.tags
}

module "eventhub" {
  source = "../../modules/eventhub"

  application_name    = "avd"
  environment = "dev"
  #   sku              = "Standard"
  resource_group_name = module.app_resource_group.rg_name
  network_rulesets = {
    default_action = "Deny"
    ip_rules       = [
      {
        ip_mask = "10.0.0.0/26"
        action  = "Allow"
      }, {
        ip_mask = "10.0.0.128/26"
        action  = "Allow"
      }
    ]
  }
  maximum_throughput_units = 0
  eventhub_config          = [
    {
      name              = "topic-1"
      message_retention = 1
      partition_count   = 4
    },
    {
      name              = "topic-2"
      message_retention = 1
      partition_count   = 2
      enable_capture = true
      capture_config = {
        encoding = "Avro"
        destination = {
          storage_account_id = module.storage_account.storage_account_id
          blob_container_name = azurerm_storage_container.storage-container.name
          blob_container_id = azurerm_storage_container.storage-container.id
        }
      }
    }
  ]
  #   eventhub_status = "SendDisabled"
#   depends_on = [azurerm_storage_container.storage-container]
}

module "storage_account" {
  source               = "../../modules/storage"
  resource_group       = module.app_resource_group.rg_name
  environment          = var.environment
  location             = var.location
  application_name     = var.application_name
  storage_account_name = "trial-${local.rg_name}-sa"
  account_kind         = "StorageV2"
  skuname              = "Standard_LRS"
}

resource "azurerm_storage_container" "storage-container" {
#   count                 = 1
  name                  = "trial-sc-1"
  storage_account_name  = module.storage_account.storage_account_name
  container_access_type = "blob"
  depends_on = [module.storage_account]
}