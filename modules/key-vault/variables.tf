variable "name" {
  type        = string
  description = "Name of the key vault"
}

variable "location" {
  type        = string
  description = "location of key vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name of key vault"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "(optional) enable purge protection"
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Key Vault."
  default     = true
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = false
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault"
  default     = "standard"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "(Optional) The number of days that items should be retained for once soft-deleted."
  default     = 7
}

variable "default_action" {
  type        = string
  description = "(The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids."
  default     = "Allow"
}

variable "bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules."
  default     = "None"
}

variable "ip_rules" {
  type        = list(any)
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  default     = []
}

variable "virtual_network_subnet_ids" {
  type        = list(any)
  description = "(Optional) One or more Subnet IDs which should be able to access this Key Vault."
  default     = []
}

variable "access_policy" {
  description = "(optional) values of access policy"
  type = list(object({
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))

  default = []
}

variable "key_values" {
  type = list(object({
    name     = string
    key_type = string
    key_size = optional(number)
    key_opts = optional(list(string), [])
  }))
  default     = []
  description = "(optional) values of key vault key"
}

variable "secret_values" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "(optional) values of key vault secrets"
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "shared"
}

variable "owners" {
  description = "Project owners email address/AAD Group name"
  type        = string
  default     = ""
}


variable "privatelink_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet where the private link is required."
  default     = null
}
variable "application_name" {}