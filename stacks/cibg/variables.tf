variable "application_name" {
  description = "Name of the application"
  type        = string
  default     = "cibg"
}

variable "environment" {
  description = "Application Environment"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "uaenorth"
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default = {
    "subnet-1" : {
      subnet_name           = "subnet-1"
      subnet_address_prefix = ["10.0.1.0/28"]
    }
    "subnet-2" : {
      subnet_name           = "subnet-2"
      subnet_address_prefix = ["10.0.1.128/28"]
    }
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

variable "aks_subnet_name" {
  description = "Subnet to use for AKS Default Node Pool"
  type        = string
}

variable "aks_api_server_authorized_ip_ranges" {
  description = "Set of authorized IP ranges to allow access to AKS API server"
  type        = list(string)
}

variable "log_analytics_ws_sku" {
  description = "(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  default     = "PerGB2018"
  type        = string
}

variable "ase_subnet_name" {
  description = "Subnet to use for App Service Environment"
  type        = string
}

variable "ase_cluster_setting" {
  description = "(Optional) Cluster settings for ASE v3"
  type = list(object({
    name  = string
    value = string
    }
  ))
  default = []
}
