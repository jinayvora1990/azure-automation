terraform {
  required_version = "~>1.6.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.51.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "null" {}