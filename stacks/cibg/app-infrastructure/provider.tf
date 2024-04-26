terraform {
  required_version = ">= 1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.13.1"
    }
  }

  #  backend "azurerm" {
  #  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
#    exec {
#      api_version = "client.authentication.k8s.io/v1beta1"
#      command     = "az"
#      args = [
#        "aks",
#        "get-credentials",
#        "--resource-group aks-test-rg",
#        "--name aks-cibg-dev-uan-1",
#        "--overwrite-existing"
#      ]
#    }
  }
}
