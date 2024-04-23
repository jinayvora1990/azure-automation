variable "resource_location" {
  type        = string
  description = "Location of Container Registry"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of Azure Container Registry"
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

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  type        = string
  default     = "Basic"
}

variable "user_assigned_identity_name" {
  description = "Name of the User Assigned Managed Identity"
  type        = string
  default     = null
}

variable "azurerm_key_vault_key" {
  description = "Specifies the name of the Key Vault Key. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "kv_name" {
  description = "The ID of the Key Vault where the Key should be created. Changing this forces a new resource to be created"
  type        = string
  default     = null
}

variable "admin_enabled" {
  description = "Whether the admin user is enabled."
  type        = bool
  default     = false
}

variable "georeplication_locations" {
  description = <<DESC
  A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  or this can be a list of `string` (each element is a location)
DESC
  type        = any
  default     = []
}

variable "images_retention_enabled" {
  description = "Specifies whether images retention is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "images_retention_days" {
  description = "Specifies the number of images retention days."
  type        = number
  default     = 90
}

variable "azure_services_bypass_allowed" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry."
  type        = bool
  default     = false
}

variable "trust_policy_enabled" {
  description = "Specifies whether the trust policy is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "allowed_cidrs" {
  description = "List of CIDRs to allow on the registry."
  default     = []
  type        = list(string)
}

variable "allowed_subnets" {
  description = "List of VNet/Subnet IDs to allow on the registry."
  default     = []
  type        = list(string)
}

variable "public_network_access_enabled" {
  description = "Whether the Container Registry is accessible publicly."
  type        = bool
  default     = true
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = false
  type        = bool
}

variable "encryption_enabled" {
  description = "Specifies whether encryption is enabled (Premium only)"
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}