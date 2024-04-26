variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}

#variable "cosmosdb_account" {
#  type = map(object({
#    offer_type                            = string
#    kind                                  = optional(string)
#    enable_free_tier                      = optional(bool)
#    analytical_storage_enabled            = optional(bool)
#    enable_automatic_failover             = optional(bool)
#    public_network_access_enabled         = optional(bool)
#    is_virtual_network_filter_enabled     = optional(bool)
#    key_vault_key_id                      = optional(string)
#    enable_multiple_write_locations       = optional(bool)
#    access_key_metadata_writes_enabled    = optional(bool)
#    mongo_server_version                  = optional(string)
#    network_acl_bypass_for_azure_services = optional(bool)
#    network_acl_bypass_ids                = optional(list(string))
#  }))
#  description = "Manages a CosmosDB (formally DocumentDB) Account specifications"
#}

#variable "databases" {
#  description = "List of databases"
#  type = map(object({
#    throughput     = optional(number)
#    max_throughput = optional(number)
#    collections = list(object({
#      name           = string
#      shard_key      = string
#      throughput     = optional(number)
#      max_throughput = optional(number)
#    }))
#  }))
#}

variable "cosmosdb_specifications" {
  description = "Specifications for Azure Cosmos DB and databases"
  type = object({
    cosmosdb_account = map(object({
      offer_type                            = string
      kind                                  = optional(string)
      enable_free_tier                      = optional(bool)
      analytical_storage_enabled            = optional(bool)
      enable_automatic_failover             = optional(bool)
      public_network_access_enabled         = optional(bool)
      is_virtual_network_filter_enabled     = optional(bool)
      key_vault_key_id                      = optional(string)
      enable_multiple_write_locations       = optional(bool)
      access_key_metadata_writes_enabled    = optional(bool)
      mongo_server_version                  = optional(string)
      network_acl_bypass_for_azure_services = optional(bool)
      network_acl_bypass_ids                = optional(list(string))
    }))
    databases = map(object({
      description = optional(string)
      throughput     = optional(number)
      max_throughput = optional(number)
      collections = list(object({
        name           = string
        shard_key      = string
        throughput     = optional(number)
        max_throughput = optional(number)
      }))
    }))
  })
}



variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  })
  description = "Consistency levels in Azure Cosmos DB"
}

variable "failover_locations" {
  #  type        = map(map(string))
  type = list(object(
    {
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool)
  }
  ))
  description = "The name of the Azure region to host replicated data and their priority."
#  default     = null
}

variable "capabilities" {
  type        = list(string)
  description = "Configures the capabilities to enable for this Cosmos DB account. Possible values are `AllowSelfServeUpgradeToMongo36`, `DisableRateLimitingResponses`, `EnableAggregationPipeline`, `EnableCassandra`, `EnableGremlin`, `EnableMongo`, `EnableTable`, `EnableServerless`, `MongoDBv3.4` and `mongoEnableDocLevelTTL`."
}

variable "virtual_network_rules" {
  description = "Configures the virtual network subnets allowed to access this Cosmos DB account"
  type = list(object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
}

variable "managed_identity" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Cosmos Account. Possible value is only SystemAssigned. Defaults to false."
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

