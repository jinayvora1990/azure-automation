variable "resource_location" {
  type        = string
  description = "Region for the recovery services vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the recovery services vault"
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

variable "sku" {
  type        = string
  description = "Sets the vault's SKU. Possible values include: Standard, RS0"
  default     = "Standard"
}

variable "immutability" {
  type        = string
  description = "Immutability settings of vault. possible values - `Locked`, `Unlocked` and `Disabled`"
  default     = "Unlocked"
}

variable "storage_mode_type" {
  type        = string
  description = "The storage type of the Recovery Services Vault. Possible values - `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant`"
  default     = "GeoRedundant"
}

variable "cross_region_restore_enabled" {
  type        = bool
  description = "Is cross region restore enabled for this Vault?"
  default     = false
}

variable "soft_delete" {
  type        = string
  description = "Status of soft delete for the backup vault"
  default     = "on"
}

variable "classic_vmware_replication_enabled" {
  type        = bool
  description = "Enable the Classic experience for VMware replication."
  default     = false
}

variable "encryption_config" {
  type = object({
    infrastructure_encryption = bool
    encryption_key = object({
      vault = object({
        key_vault_name      = string
        resource_group_name = string
      })
      rotation_policy = optional(object({
        expire_after         = string
        notify_before_expiry = string
        time_before_expiry   = string
      }))
    })
  })
  description = "Encryption details for the vault"
  default     = null
}

variable "monitoring" {
  type = object({
    alerts_for_all_job_failures            = optional(bool)
    alerts_for_critical_operation_failures = optional(bool)
  })
  description = "Monitoring configuration for the vault"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default     = {}
}