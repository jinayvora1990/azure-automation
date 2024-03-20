variable "resource_group_name" {
  description = "Name of the resource group in which the subnets will be created"
  type        = string
  default     = "rg-vnet-avd-prod-uaenorth-01"
}

variable "virtual_network_name" {
  description = "Name of the virtual network in which the subnets will be created"
  type        = string
  default     = "vnet-avd-uaenorth-01"
}

variable "subnets" {
  description = "List of subnets to be created"
  type        = list(object({
    name                            = string
    address_prefixes                = list(string)
    private_endpoint_network_policy = bool
    depends_on                      = list(string)
  }))
  default     = []
}


variable "security_rules" {
  description = "List of security rules to be applied"
  type        = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = string
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
    description                  = string
  }))
  default     = []
}

variable "location" {
  description = "Location of the Azure Network Security Group"
  type        = string
  default     = "uaenorth"
}

variable "resource_groups" {
  description = "Map of resource group names and their locations"
  type        = map(string)
  default = {
    "shared"   = "rg-shared-avd-prod-uaenorth-01"
    "storage"  = "rg-storage-avd-prod-uaenorth-01"
    "avd"      = "rg-vnet-avd-prod-uaenorth-01"
    "akv"      = "rg-akv-avd-prod-uaenorth-01"
  }
}