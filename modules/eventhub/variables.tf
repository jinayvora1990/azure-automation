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
}

variable "environment" {
  type        = string
  description = "Environment where redis cache is provisioned"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {}
}

variable "sku" {
  type        = string
  description = "The sku for the eventhub namespace"
  default     = "Basic"
}

variable "capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = 1
}

variable "auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace"
  default     = false
}

variable "maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Is public network access enabled for the EventHub Namespace"
  default     = false
}

variable "zone_redundant"{
  type = bool
  description = "Is the eventhub namespace zone redundant"
  default = false
}

variable "network_rulesets" {
  type = object({
    default_action                 = string
    trusted_service_access_enabled = optional(bool)
    virtual_network_rules          = optional(list(object({
      subnet_id                                       = string
      ignore_missing_virtual_network_service_endpoint = optional(bool)
    })), [])
    ip_rules = optional(list(object({
      ip_mask = string
      action  = optional(string)
    })), [])
  })
  description = ""
  default     = null
}

variable "message_retention" {
  type        = number
  description = "Specifies the number of days to retain the events for this Event Hub."
  default     = 1
}

variable "partition_count" {
  type        = number
  description = "Specifies the current number of shards on the Event Hub."
  default     = 4
}

variable "eventhub_status" {
  type        = string
  description = "Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled"
  default     = "Active"
}