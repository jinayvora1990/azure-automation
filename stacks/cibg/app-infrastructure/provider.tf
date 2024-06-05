terraform {
  required_version = ">= 1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
  }

  #  backend "azurerm" {
  #  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true

    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
