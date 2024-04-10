variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
  default     = ""
}

variable "env" {
  type        = string
  description = "Environment where redis cache is provisioned"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {}
}

#service plan
variable "service_plan_sku" {
  default     = "B1"
  description = "The SKU for the service plan"
  type        = string
}

variable "plan_worker_count" {
  type        = number
  description = "The number of Workers (instances) to be allocated"
  default     = 1
}

#web app
variable "web_app_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "The subnet id which will be used by this Web App for regional virtual network integration."
  default     = null
}

variable "app_settings" {
  type        = map(string)
  description = "App Settings map"
  default = {}
}

variable "public_access" {
  type        = bool
  description = "Status of public network access to the web app"
  default     = true
}

variable "existing_service_plan" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = ""
  default     = null
}

variable "worker_count" {
  type        = number
  description = ""
  default     = 1
}

variable "application_stack" {
  type        = object({})
  description = ""
  default     = null
}

variable "health_check" {
  type = object({
    path          = string
    eviction_time = number
  })
  description = ""
  default     = null
}

variable "ip_restriction" {
  type = object({
    rules = list(object({
      action  = optional(string)
      headers = optional(list(object({
        x_azure_fdid      = optional(string)
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      ip_address                = optional(string)
    }))
    default_action = string
  })
  description = ""
  default     = null
  validation {
    condition = (
    length([
      for key, value in var.ip_restriction.rules :
      ((key == var.ip_restriction.rules.virtual_network_subnet_id || key == var.ip_restriction.rules.ip_address || key == var.ip_restriction.rules.service_tag) && value != null)
    ]) <= 1
    )
    error_message = "Only one of 'ip_address', 'service_tag' or 'virtual_network_subnet_id' is expected"
  }
}

variable "load_balancing_mode" {
  type        = string
  description = "The load balancing mode for the app service. Possible values are WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin"
  default     = "LeastRequests"
}

# variable "storage_accounts" {
#   type = list(object({
#     access_key   = string
#     account_name = string
#     name         = string
#     share_name   = string
#     type         = string
#   }))
#   description = ""
#   default = []
# }

variable "custom_domain" {
  type = object({
    hostname    = string
    certificate = optional(object({
      name  = string
      vault = object({
        name           = string
        resource_group = string
      })
    }))
  })
  description = "Map a custom domain with the app service. If you do not pass the certificate, a managed certificate is created by azure"
  default     = null
}

variable "cors" {

}

#variable "log_analytics" {
#  type = object({
#    workspace_name      = string
#    resource_group_name = string
#  })
#  description = "Log Analytics workspace"
#  default     = null
#}
#
#variable "privatelink_subnet" {
#  type = object({
#    name           = string
#    vnet_name      = string
#    resource_group = string
#  })
#  description = "Subnet where the private link is required."
#  default     = null
#}


