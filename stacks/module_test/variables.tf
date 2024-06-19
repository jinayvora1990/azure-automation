variable "location" {
  type        = string
  description = "location of resource group"
  default     = "uaenorth"
}

variable "environment" {
  type        = string
  description = "Environment where resource to be deployed"
  default     = "dev"
}

variable "application_name" {
  type        = string
  description = "Name of application project shortcode"
  default     = "cibg"
}

variable "policy_details" {
  type = map(object({
    assignment_effect     = string
    assignment_parameters = any
  }))
  default = {}
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default = {
  }
  type = map(object({
    subnet_name                                   = string
    subnet_address_prefix                         = list(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
    nsg_inbound_rules                             = optional(list(list(string)), [])
    nsg_outbound_rules                            = optional(list(list(string)), [])
    route_table_rules                             = optional(list(list(string)), [])

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string), [])
      })
    }))
  }))
}

variable "provision_modules" {
  description = "Select what modules should be provisioned"
  default = {
    acr             = true
    cosmosdb        = true
    eventhub        = true
    kv              = true
    law             = true
    network         = true
    policy          = true
    postgres        = true
    pvt_dns         = true
    rg              = true
    storage_account = true
    aks             = true
  }
  type = object({
    acr             = bool
    cosmosdb        = bool
    eventhub        = bool
    kv              = bool
    law             = bool
    network         = bool
    policy          = bool
    postgres        = bool
    pvt_dns         = bool
    rg              = bool
    storage_account = bool
    aks             = bool
  })
}

variable "aks_api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "List of IP Address which can access aks cluster"
}

variable "azure_active_directory_admin_group_object_ids" {
  type        = list(string)
  default     = []
  description = "(optional) A list of Object IDs of Azure Active Directory Groups which should have Cluster Admin Role on the Cluster. Used only when azure_active_directory_managed is set to true."
}

variable "aks_network_plugin" {
  type        = string
  description = " Network Plugin for Azure Kubernetes Service"
  default     = "azure"
}

variable "acr_sku" {
  type        = string
  description = "SKU Name for ACR Registry"
  default     = "Premium"
}

variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  })
  description = "Consistency levels in Azure Cosmos DB"
}

variable "databases" {
  description = "MongoDB Databases"
  type = map(object({
    description    = optional(string)
    throughput     = optional(number)
    max_throughput = optional(number)
    collections = list(object({
      name           = string
      shard_key      = string
      throughput     = optional(number)
      max_throughput = optional(number)
    }))
  }))
}


variable "failover_locations" {
  type = list(object(
    {
      location          = string
      failover_priority = number
      zone_redundant    = optional(bool)
    }
  ))
  description = "The name of the Azure region to host replicated data and their priority."
  default     = null
}

variable "capabilities" {
  type        = list(string)
  description = "Configures the capabilities to enable for this Cosmos DB account. Possible values are `AllowSelfServeUpgradeToMongo36`, `DisableRateLimitingResponses`, `EnableAggregationPipeline`, `EnableCassandra`, `EnableGremlin`, `EnableMongo`, `EnableTable`, `EnableServerless`, `MongoDBv3.4` and `mongoEnableDocLevelTTL`."
}
#

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  type        = list(string)
}

variable "create_ddos_plan" {
  description = "Create an ddos plan - Default is false"
  type        = bool
  default     = true
}

variable "ddos_plan_name" {
  description = "The name of AzureNetwork DDoS Protection Plan"
  type        = string
}

variable "postgres_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL flexible Server. The name of the SKU, follows the tier + family + cores pattern (e.g. D2s_v3, D2ds_v4). For available skus run `az postgres flexible-server list-skus --location=LOCATION`"
}

variable "sql_version" {
  type        = string
  description = "Specifies the version of PostgreSQL to use. Valid values are 11, 12, 13, 14, 15, 16"
}

variable "storage_tier" {
  type        = string
  description = "The name of storage performance tier for IOPS of the PostgreSQL Flexible Server. Possible values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70 or P80. Default value is dependant on the storage_mb value"
}
