data "azurerm_user_assigned_identity" "registry_identity" {
  for_each            = var.registries != null ? var.registries : {}
  name                = each.value.identity.name
  resource_group_name = each.value.identity.resource_group
}

data "azurerm_key_vault" "secret_kv" {
  for_each            = var.secrets != null ? var.secrets : {}
  name                = each.value.kv_secret.kv_name
  resource_group_name = each.value.kv_secret.kv_resource_group
}

data "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets != null ? var.secrets : {}
  name         = each.value.kv_secret.name
  key_vault_id = data.azurerm_key_vault.secret_kv[each.key].id
}

data "azurerm_user_assigned_identity" "kv_identity" {
  for_each            = var.secrets != null ? var.secrets : {}
  name                = each.value.identity.name
  resource_group_name = each.value.identity.resource_group
}

data "azurerm_user_assigned_identity" "ca_job_identity" {
  count               = var.ca_job_identity_names != [] ? length(var.ca_job_identity_names) : 0
  name                = var.ca_job_identity_names[count.index].name
  resource_group_name = var.ca_job_identity_names[count.index].resource_group_name
}

data "azurerm_subnet" "subnet" {
  count                = var.subnet != null ? 1 : 0
  name                 = var.subnet.name
  resource_group_name  = var.subnet.resource_group
  virtual_network_name = var.subnet.vnet_name
}
