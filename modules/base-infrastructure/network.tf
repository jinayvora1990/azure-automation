resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.app_name}-${local.environment}-${local.region_shortcode}-1"
  location            = local.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = local.if_ddos_enabled

    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }
}

resource "azurerm_network_ddos_protection_plan" "ddos" {
  count               = var.create_ddos_plan ? 1 : 0
  name                = var.ddos_plan_name
  resource_group_name = var.resource_group_name
  location            = local.location
  tags                = merge({ "Name" = format("%s", var.ddos_plan_name) }, var.tags, )
}

resource "azurerm_network_watcher" "nwatcher" {
  count               = var.create_network_watcher != false ? 1 : 0
  name                = "NetworkWatcher_${local.location}"
  location            = local.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = format("%s", "NetworkWatcher_${local.location}") }, var.tags, )
}

resource "azurerm_subnet" "snet" {
  for_each                                      = var.subnets
  name                                          = "snet-${each.value.subnet_name}"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = each.value.subnet_address_prefix
  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", null)
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", null)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != null ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }
}