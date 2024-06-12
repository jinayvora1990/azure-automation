module "cosmosdb" {
  count               = var.provision_modules.cosmosdb ? 1 : 0
  source              = "../../modules/cosmosdb"
  application_name    = var.application_name
  environment         = var.environment
  resource_group_name = module.resource_group[0].rg_name

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

  privatelink_subnet = {
    name           = module.base-infra[0].subnet_names[2]
    vnet_name      = module.base-infra[0].vnet_name
    resource_group = module.resource_group[0].rg_name
  }
}