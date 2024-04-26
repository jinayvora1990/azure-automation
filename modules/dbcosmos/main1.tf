
locals {
#  resource_group_name = element(coalesce(data.azurerm_resource_group.rgrp[*].name, azurerm_resource_group.rg[*].name, [""]), 0)
#  location            = element(coalesce(data.azurerm_resource_group.rgrp[*].location, azurerm_resource_group.rg[*].location, [""]), 0)
  location = try(
    element(data.azurerm_resource_group.rgrp[*].location, 0),
    element(azurerm_resource_group.rg[*].location, 0)
  )

  default_failover_locations = [{
    location = local.location
  }]

  collections = flatten([
    for account_name, db in var.cosmosdb_specifications.cosmosdb_account : [
      for db_key, db_details in var.cosmosdb_specifications.databases : [
        for col in db_details.collections : {
          name           = col.name
          database       = db_key
          shard_key      = col.shard_key
          throughput     = col.throughput
          max_throughput = col.max_throughput
          account_name   = account_name
        }
      ]
    ]
  ])
}


resource "random_integer" "intg" {
#c  count   = var.create_resource_group ? 1 : 0
  min     = 500
  max     = 50000
  keepers = {
    name = azurerm_resource_group.rg.name
  }
}

resource "azurerm_cosmosdb_account" "main" {
  for_each            = var.cosmosdb_specifications.cosmosdb_account
  tags                = var.tags
  name                = "${each.key}-${random_integer.intg.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  offer_type          = each.value.offer_type
  kind                = each.value.kind
  public_network_access_enabled = each.value.public_network_access_enabled

  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }

  dynamic "geo_location" {
    for_each = var.failover_locations == null ? local.default_failover_locations : var.failover_locations
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }

  dynamic "capabilities" {
    for_each = toset(var.capabilities)
    content {
      name = capabilities.key
    }
  }

  dynamic "identity" {
    for_each = var.managed_identity == true ? [1] : [0]
    content {
      type = "SystemAssigned"
    }
  }
}

#resource "azurerm_cosmosdb_mongo_database" "main" {
#  for_each            = var.cosmosdb_specifications.databases
#
#  name                = each.key
#  resource_group_name = azurerm_resource_group.rg.name
#  account_name        = azurerm_cosmosdb_account.main[var.cosmosdb_specifications.cosmosdb_account].name
#  throughput          = each.value.throughput
#}

resource "azurerm_cosmosdb_mongo_database" "main" {
  for_each            = var.cosmosdb_specifications.databases
  name                = each.key
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.main[keys(var.cosmosdb_specifications.cosmosdb_account)[0]].name
  throughput          = each.value.throughput
}

resource "azurerm_cosmosdb_mongo_collection" "main" {
  for_each            = {
    for col in local.collections : col.name => col
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg.name
  #account_name        = azurerm_cosmosdb_account.main[each.value].name
  #account_name = each.value.account_name
  account_name        = azurerm_cosmosdb_account.main[keys(var.cosmosdb_specifications.cosmosdb_account)[0]].name
  database_name       = each.value.database
  shard_key           = each.value.shard_key
  throughput          = each.value.throughput
  index {
    keys   = ["_id"]
    unique = true
  }
}
