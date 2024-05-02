locals {
  cosmos_rg = format("rg-%s-%s-%s-cosmos", local.application_name, local.environment, local.region_shortcode)
}

module "mongo_resource_group" {
  source  = "../../modules/resource-groups"
  rg_name = local.cosmos_rg
  tags    = local.tags
}

module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  application_name    = "cibg"
  environment         = "dev"
  resource_group_name = module.mongo_resource_group.rg_name

  capabilities = ["EnableMongo"]

  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  kind       = "MongoDB"
  offer_type = "Standard"

  databases = {
    mydb1 = {
      description = "My first database"
      throughput  = 400
      collections = [
        { name = "col0", shard_key = "somekey_0" },
        { name = "col1", shard_key = "somekey_1" }
      ]
    },
    mydb2 = {
      description    = "My second database"
      max_throughput = 4000
      collections    = [{ name = "mycol2", shard_key = "someother_key" }]
    },
    mydb3 = {
      description = "My third database"
      collections = [{ name = "mycol3", shard_key = "mycol3_key" }]
    }
  }

  failover_locations = [{
    location          = "uaenorth"
    failover_priority = 0
    zone_redundant    = false
  }]
}
