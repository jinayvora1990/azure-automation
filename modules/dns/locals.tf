locals {
  rg               = var.resource_group
  location         = lower(var.location)
  common_tags      = { module = "private-dns-zone" }
}