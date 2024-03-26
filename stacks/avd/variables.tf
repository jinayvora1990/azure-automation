variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type = string
}

variable "storage_account_name" {
  description = "The name of the azure storage account"
  default     = ""
  type        = string
}

variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string }))
  default     = []
}

variable "skuname" {
  type = string
}
