variable "resource_location" {
  type        = string
  description = "location of key vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name of key vault"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
}

variable "environment" {
  type        = string
  description = "Environment to provision resources"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}

variable "owners" {
  description = "Project owners email address/AAD Group name"
  type        = string
  default     = ""
}

variable "replica_timeout_seconds" {
  type        = number
  description = "Replica Timeout time in seconds"
  default     = "30"
}

variable "replica_retry_limit" {
  type        = number
  description = "Retry limit for replicas"
  default     = 0
}

variable "workload_profile" {
  description = "Workload Profile for container app environment"
  type = object({
    name                  = string
    workload_profile_type = string
  })
}

variable "registries" {
  description = "Registry details for the container app job"
  type = map(object({
    name = string
    identity = optional(object({
      name           = string
      resource_group = string
    }))
  }))
  default = {}
}

variable "secrets" {
  description = "Secrets for the container app job"
  type = map(object({
    name = string
    kv_secret = object({
      name              = string
      kv_name           = string
      kv_resource_group = string
    })
    identity = object({
      name           = string
      resource_group = string
    })
  }))
  default = {}
}

variable "container_config" {
  description = "Container configuration for the container app job"
  type = object({
    name   = string
    cpu    = string
    memory = string
    image  = string
    env = optional(map(
      object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })
    ), {})
  })
}

variable "ca_job_identity_names" {
  description = "Container App job identities"
  type = list(object({
    name                = string
    resource_group_name = string
  }))
  default = []
}

variable "subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet for the container app environment"
  default     = null
}

variable "event_trigger_config" {
  type = object({
    parallelism                 = optional(number)
    replica_completion_count    = optional(number)
    min_executions              = optional(number)
    max_executions              = optional(number)
    polling_interval_in_seconds = optional(number)
    rules = optional(object({
      name              = string
      rule_type         = string
      metadata          = optional(map(string))
      auth_secret       = string
      trigger_parameter = string
    }))
  })
  default     = null
  description = "Configuration for the event trigger"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Id of the log analytics workspace"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}