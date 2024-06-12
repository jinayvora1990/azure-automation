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
  default     = ["10.0.0.0/24"]
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


variable "aks_api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "List of IP Address which can access aks cluster"

}