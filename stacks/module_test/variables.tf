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
  })
}
