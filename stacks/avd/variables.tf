variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = list(string)
}

variable "storage_accounts" {
  description = "Storage Account details"
  type = list(object({
    name           = string
    resource_group = string
    containers = list(object({
      name        = string
      access_type = string
    }))
    skuname = string
  }))
  default = []
}

variable "subnets_for_vnet" {
  description = "List of subnets to be created"
  type        = map(object(
    {
    name                            = string
    address_prefixes                = list(string)
    private_endpoint_network_policies_enabled = bool
  }
  ))
  default = {}
}

variable "peering_to_hub_name" {
  default = "peer-avd-to-Hub"
}

variable "nsg_name" {
  default = "nsg-snet-avd-prod-uaenorth-001"
}
#
#variable "resource_groups" {
#  description = "Map of resource group names and their locations"
#  type        = map(string)
#  default = {
#    "shared"   = "rg-shared-avd-prod-uaenorth-01"
#    "storage"  = "rg-storage-avd-prod-uaenorth-01"
#    "avd"      = "rg-vnet-avd-prod-uaenorth-01"
#    "akv"      = "rg-akv-avd-prod-uaenorth-01"
#  }
#}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The name of the location to create the resources in."
  type        = string
}