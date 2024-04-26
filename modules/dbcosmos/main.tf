#------------------------------------------------------------
# Local configuration - Default (required). 
#------------------------------------------------------------


locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)

  default_failover_locations = [{
    location = local.location
  }]
#  collections = flatten([
#    for db_key, db in var.databases : [
#      for col in db.collections : {
#        name           = col.name
#        database       = db_key
#        shard_key      = col.shard_key
#        throughput     = col.throughput
#        max_throughput = col.max_throughput
#      }
#    ]
#  ])
}


#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------

data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  #count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}


#-------------------------------------------------------------
# CosmosDB (formally DocumentDB) Account - Default (required)
#-------------------------------------------------------------

resource "random_integer" "intg" {
  #count    = var.create_resource_group ? 1 : 0
  min = 500
  max = 50000
  keepers = {
    name = azurerm_resource_group.rg.name
  }
  #keepers  = var.create_resource_group ? { name = azurerm_resource_group.rg[0].name } : {}
}

resource "azurerm_cosmosdb_account" "main" {
  for_each            = var.cosmosdb_account
  tags = var.tags
  name                = format("%s-%s", each.key, random_integer.intg.result)
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  offer_type          = each.value["offer_type"]
  kind                = each.value["kind"]
  public_network_access_enabled         = each.value["public_network_access_enabled"]

  consistency_policy {
    consistency_level       = lookup(var.consistency_policy, "consistency_level", "BoundedStaleness")
    max_interval_in_seconds = lookup(var.consistency_policy, "consistency_level") == "BoundedStaleness" ? lookup(var.consistency_policy, "max_interval_in_seconds", 5) : null
    max_staleness_prefix    = lookup(var.consistency_policy, "consistency_level") == "BoundedStaleness" ? lookup(var.consistency_policy, "max_staleness_prefix", 100) : null
  }

  dynamic "geo_location" {
    for_each = var.failover_locations == null ? local.default_failover_locations : var.failover_locations
    content {
      #   prefix            = "${format("%s-%s", each.key, random_integer.intg.result)}-${geo_location.value.location}"
      location          = geo_location.value.location
      failover_priority = lookup(geo_location.value, "failover_priority", 0)
      zone_redundant    = lookup(geo_location.value, "zone_redundant", false)
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

#-------------------------------------------------------------
# CosmosDB (formally DocumentDB) Database - Default (required)
#-------------------------------------------------------------


#resource "azurerm_cosmosdb_mongo_database" "main" {
#  for_each = var.databases
#
#  name                = each.key
#  resource_group_name = azurerm_resource_group.rg.name
#  account_name        = azurerm_cosmosdb_account.main.name
#  throughput          = each.value.throughput
#
#  dynamic "autoscale_settings" {
#    for_each = each.value.max_throughput != null ? [each.value.max_throughput] : []
#    content {
#      max_throughput = autoscale_settings.value
#    }
#  }
#}


#-------------------------------------------------------------
# CosmosDB (formally DocumentDB) Collection
#-------------------------------------------------------------

#resource "azurerm_cosmosdb_mongo_collection" "main" {
#  for_each = { for col in local.collections : col.name => col }
#
#  name                = each.value.name
#  resource_group_name = azurerm_resource_group.main.name
#  account_name        = azurerm_cosmosdb_account.main.name
#  database_name       = each.value.database
#  shard_key           = each.value.shard_key
#  throughput          = each.value.throughput
#
#  index {
#    keys   = ["_id"]
#    unique = true
#  }
#
#  dynamic "autoscale_settings" {
#    for_each = each.value.max_throughput != null ? [each.value.max_throughput] : []
#    content {
#      max_throughput = autoscale_settings.value
#    }
#  }
#
#  lifecycle {
#    ignore_changes = [index, default_ttl_seconds]
#  }
#
#  depends_on = [azurerm_cosmosdb_mongo_database.main]
#}
