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
  default     = {}
}

variable "service_plan_sku" {
  default     = "B1"
  description = "The SKU for the plan"
  type        = string
}

variable "max_elastic_worker_count" {
  type        = number
  description = "The maximum number of workers to use in an Elastic SKU Plan"
  default     = null
}

variable "worker_count" {
  type        = number
  description = "The number of Workers (instances) to be allocated"
  default     = null
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "The OS type for the service plan"
}