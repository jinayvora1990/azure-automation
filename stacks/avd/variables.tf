variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = list(string)
}

variable "storage_accounts" {
  description = "Storage Account details"
  type = list(object({
    name           = string
    resource_group = string
    containers = list(object({
      name        = string
      access_type = string
    }))
    skuname = string
  }))
  default = []
}