variable "rg_name" {
  type    = string
  default = "test_module"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "cibg"
}

variable "environment" {
  description = "Application Environment"
  type        = string
  default     = "sit"
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
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