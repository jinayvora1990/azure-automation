variable "resource_location" {
  type        = string
  description = "Region for the backup vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the backup vault"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
  default     = ""
}

variable "env" {
  type        = string
  description = "Environment where backup vault is provisioned"
  default     = "dev"
}

variable "datastore_type" {
  type        = string
  description = "The datastore type of the backup vault. Possible values are `ArchiveStore`, `OperationalStore` and `VaultStore`"
  default     = "VaultStore"
}

variable "redundancy" {
  type        = string
  description = "The backup storage redundancy of the backup vault. Possible values are `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant`"
  default     = "GeoRedundant"
}

variable "identity" {
  type = object({
    type = string
  })
  description = "Identity for the resource"
  default     = null
}

variable "retention_duration" {
  type        = number
  description = "The soft delete retention duration for the Backup Vault. Possible values are between 14 and 180."
  default     = 14
}

variable "soft_delete" {
  type        = string
  description = "Status of soft delete for the backup vault"
  default     = "on"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default     = {}
}