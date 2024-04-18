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
  default     = "Y1"
  description = "The SKU for the service plan"
  type        = string
  validation {
    condition     = contains(["EP1", "EP2", "EP3", "Y1"], var.service_plan_sku)
    error_message = "Valid values for service plan sku are: (Y1, EP1, EP2, and EP3)"
  }
}

variable "max_elastic_worker_count" {
  type        = number
  description = "The maximum elastic workers present in a elastic service plan"
  default     = null
}

#function app
variable "web_app_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "The subnet id which will be used by this Web App for regional virtual network integration."
  default     = null
}

variable "env_vars" {
  type        = map(string)
  description = "The environment variables map"
  default = {}
}

variable "artifact_url" {
  type        = string
  description = "The url for the artifact to run"
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Status of public network access to the web app"
  default     = true
}

variable "existing_service_plan" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "The details of an existing service plan"
  default     = null
}

variable "worker_count" {
  type        = number
  description = "The number of workers assigned to the service plan and the app-service"
  default     = 1
}

variable "daily_memory_time_quota" {
  type        = number
  description = "The amount of memory in gigabyte-seconds that the application is allowed to consume per day."
  default     = null
}

variable "app_service_logs" {
  type = object({
    disk_quota_mb         = number
    retention_period_days = number
  })
  description = "The log configuration for the function app"
  default     = null
}

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

variable "backup" {
  type = object({
    backup_sa = object({
      name           = string
      resource_group = string
    })
    enabled  = optional(bool)
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      start_time               = optional(string)
      retention_period_days    = optional(number)
      keep_at_least_one_backup = optional(bool)
    })
  })
  description = "The backup configuration for the app service. Skip this for the default backup configuration"
  default     = null
}

variable "application_insights_enabled" {
  description = "Use Application Insights for this App Service"
  type        = bool
  default     = false
}

variable "site_config" {
  type = object({
    always_on                         = optional(bool)
    app_command_line                  = optional(string)
    default_documents                 = optional(list(string))
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(string)
    http2_enabled                     = optional(string)
    load_balancing_mode               = optional(string)
    application_stack                 = optional(map(string))
    cidr_restriction                  = optional(list(object({
      name     = optional(string)
      priority = optional(number)
      action   = optional(string)
      cidr     = optional(string)
      #       headers  = optional(object({}))
    })), [])
    subnet_restriction = optional(list(object({
      name      = optional(string)
      priority  = optional(number)
      action    = optional(string)
      subnet_id = optional(string)
      #       headers   = optional(object({}))
    })), [])
    service_tags_restriction = optional(list(object({
      name        = optional(string)
      priority    = optional(number)
      action      = optional(string)
      service_tag = optional(string)
      #       headers     = optional(object({}))
    })), [])
    default_ip_restriction_action = optional(string)
    app_service_logs              = optional(object({
      disk_quota_mb         = number
      retention_period_days = number
    }))
    cors = optional(object({
      allowed_origins     = optional(list(string))
      support_credentials = optional(bool)
    }))
  })
  default = {}
  description = "Site config for App Service."
}

variable "connection_strings" {
  description = "Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string"
  type        = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}