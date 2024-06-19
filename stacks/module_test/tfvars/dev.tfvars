policy_details = {
  deny_azure_regions = {
    assignment_effect = "Deny"
    assignment_parameters = {
      listOfRegionsAllowed = ["uaenorth", "uswest"]
    }
  },
  deny_storage_sku = {
    assignment_effect = "Deny"
    assignment_parameters = {
      allowedSku = ["Standard_LRS", "Standard_GRS"]
    }
  }
}


#cosmos DB Variables
consistency_policy = {
  consistency_level       = "BoundedStaleness"
  max_interval_in_seconds = 300
  max_staleness_prefix    = 100000
}

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

capabilities = ["EnableMongo"]



#AKS variables
azure_active_directory_admin_group_object_ids = ["77e919ac-290c-4493-b3aa-0a74aaf69ca5"]
aks_api_server_authorized_ip_ranges           = ["0.0.0.0/0"]


#Base Network Variables
subnets = {
  "subnet-1" : {
    subnet_name           = "subnet-1"
    subnet_address_prefix = ["10.0.0.0/25"]
    service_endpoints     = ["Microsoft.AzureCosmosDB"]
    nsg_inbound_rules = [
      ["test123", 100, "Inbound", "Deny", "Tcp", "*", "*", "*", "*"],
    ]
    nsg_outbound_rules = [
      ["testOut", 100, "Outbound", "Deny", "Udp", "*", "*", "*", "*"],
    ]
    route_table_rules = [
      #       ["rt_rule_1", "10.0.0.0/30", "VirtualAppliance", "VirtualAppliance"],
      ["rt_rule_2", "10.0.0.64/30", "VnetLocal", null]
    ]
  }
  "subnet-2" : {
    subnet_name           = "subnet-2"
    subnet_address_prefix = ["10.0.0.128/25"]
  }
  "subnet-3" : {
    subnet_name           = "subnet-3"
    subnet_address_prefix = ["10.0.1.0/24"]
  }
  "subnet-4" : {
    subnet_name           = "subnet-4"
    subnet_address_prefix = ["10.0.2.0/24"]
  }
}

dns_servers      = ["10.0.0.4", "10.0.0.5"]
create_ddos_plan = true
ddos_plan_name   = "DDOS-PP"

#Postgres Variables

postgres_sku_name = "GP_Standard_D2s_v3"
sql_version       = "12"
storage_tier      = "P15"