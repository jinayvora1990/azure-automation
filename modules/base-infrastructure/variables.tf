variable "subscription_id" {
  description = "ID of the Application Subscription."
  type        = string
  default     = null
}

variable "azure_mgmt_group" {
  description = "Name of the Management Group where application subscription needs to be associated"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Resource group to host base resources"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = "uaenorth"
}

variable "environment" {
  description = "Application Environment"
  type        = string
}

variable "hub_vnet_id" {
  description = "Remote Hub VNET ID"
  type        = string
  default     = null
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
}

variable "create_ddos_plan" {
  description = "Create an ddos plan - Default is false"
  type        = bool
  default     = false
}

variable "ddos_plan_name" {
  description = "The name of AzureNetwork DDoS Protection Plan"
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  type        = list(string)
  default     = []
}

variable "create_network_watcher" {
  description = "Controls if Network Watcher resources should be created for the Azure subscription"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "A map of subnets to be created"
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}