## Modules

* Will be using the resource name and resource group name to reference the resource in a module, because
    * It helps reduce the dependency on the id, which are long and difficult to maintain. Also, therefore accommodates
      any resources created from the Azure dashboard.
    * It will improve the maintainability of the modules as the outputs required will not change based on the other
      modules dependent on the given module's resource(s).

## Naming Convention

* The resources have been named in the following convention
    * Primary Resources

      `<resource_abbreviation>-<app_name>-<environemnt>-<shortened_resource_location>-<random-8-letter-string>`

        * This random 8 letter string is defined inside the 'utility/random-identifier'
    * Secondary resources in module

      `<primary_resource_abbreviation>-<secondary_resource_abbreviation>-<app_name>-<environemnt>-<shortened_resource_location>-<random-8-letter-string>`

* The resource location has been shortened to three digits using the following criteria

  `{uaenorth: uan, uaecentral: uac}`

### Abbreviation used

| Resource                   | Abbreviation |
|----------------------------|--------------|
| Resource Groups            | rg           |
| Redis Cache                | redis        |
| Private Endpoint           | pep          |
| Private Link               | pl           |
| Monitor Diagnostic Setting | diag         |
| Backup Vault               | bvault       |
| Recovery Services Vault    | rsv          |           
| Key Vault Key              | kvkey        |
| Virtual Network            | vnet         |
| Subnets                    | snet         |
| Route Tables               | rt           |
| Postgresql Flexi Server    | psql         |
| MySQL Flexi Server         | mysql        |
| Managed Identity           | id           |
| Storage Container          | sc           |
| App Service Certificate    | sslcert      |
| App Service Plan           | asp          |
| App Service Environment    | ase          |
| Storage Container          | sc           |
| Log Analytics Workspace    | law          |


