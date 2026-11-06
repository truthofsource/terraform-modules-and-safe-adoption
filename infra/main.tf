terraform {
  required_version = ">= 1.11.0"
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" } }
}
provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}
locals {
  selected = var.enable_reference ? { nonproduction = { cidr = "10.20.0.0/16", functions = "10.20.1.0/24", endpoints = "10.20.2.0/24" }, production = { cidr = "10.40.0.0/16", functions = "10.40.1.0/24", endpoints = "10.40.2.0/24" } } : {}
}
module "network" {
  for_each                          = local.selected
  source                            = "./modules/network"
  location                          = "eastus2"
  address_space                     = [each.value.cidr]
  functions_subnet_prefixes         = [each.value.functions]
  private_endpoints_subnet_prefixes = [each.value.endpoints]
  resource_group_name               = "rg-example-${each.key}-network"
  virtual_network_name              = "vnet-example-${each.key}"
  functions_subnet_name             = "functions-integration"
  private_endpoints_subnet_name     = "private-endpoints"
  tags                              = { environment = each.key, managed_by = "terraform" }
}
module "documents" {
  for_each                     = local.selected
  source                       = "./modules/storage"
  location                     = "eastus2"
  account_name                 = each.key == "production" ? "examplereferenceprod001" : "examplereferencenp001"
  resource_group_name          = "rg-example-${each.key}-documents"
  container_names              = ["documents", "evidence"]
  log_analytics_workspace_id   = "/subscriptions/${var.subscription_id}/resourceGroups/rg-example-observability/providers/Microsoft.OperationalInsights/workspaces/law-example"
  admins_group_object_id       = "00000000-0000-4000-8000-000000000002"
  contributors_group_object_id = "00000000-0000-4000-8000-000000000003"
  readers_group_object_id      = "00000000-0000-4000-8000-000000000004"
  tags                         = { environment = each.key, managed_by = "terraform" }
}
output "network_names" { value = { for key, item in module.network : key => item.virtual_network_name } }
output "document_names" { value = { for key, item in module.documents : key => item.account_name } }
