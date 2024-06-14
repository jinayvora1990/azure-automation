terraform {
  required_version = "~> 1.6.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
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