module "cosmosdb"{
  source = "../../modules/dbcosmos"
  capabilities = ["EnableMongo"]
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  cosmosdb_account = {
    default = {
      offer_type                            = "Standard"
      kind                                  = "MongoDB"
      public_network_access_enabled         = true
      enable_free_tier                      = true
      analytical_storage_enabled            = false
      enable_automatic_failover             = false
      is_virtual_network_filter_enabled     = false
      key_vault_key_id                      = null
      enable_multiple_write_locations       = false
      access_key_metadata_writes_enabled    = false
      mongo_server_version                  = "4.2"
      network_acl_bypass_for_azure_services = false
      network_acl_bypass_ids                = [""]
    }
  }

  create_resource_group = true
  #failover_locations = ["uaenorth",0,true]
  failover_locations = [{

    location          = "uaenorth"
    failover_priority = 0
    zone_redundant    = false
  }]

  tags = {
    project = "adcb"
    owners  = "Sudhanshu"
  }
  location = "uaenorth"
  managed_identity = "SystemAssigned"
  resource_group_name = "test-cosmosdb"
  virtual_network_rules = [
    {
      id = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/default"
      ignore_missing_vnet_service_endpoint = false
    }
    ]
}