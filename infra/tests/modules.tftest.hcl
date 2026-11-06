mock_provider "azurerm" {}
variables { subscription_id = "00000000-0000-4000-8000-000000000001" }
run "default_off" {
  command = plan
  assert {
    condition     = length(module.network) == 0 && length(module.documents) == 0
    error_message = "No example cloud selection by default."
  }
}
run "two_environment_composition" {
  command = plan
  variables { enable_reference = true }
  assert {
    condition     = output.network_names["production"] != output.network_names["nonproduction"] && output.document_names["production"] != output.document_names["nonproduction"]
    error_message = "Environments must retain distinct names and module instances."
  }
  assert {
    condition     = length(module.documents["production"].container_names) == 2 && length(module.documents["nonproduction"].container_names) == 2
    error_message = "Both storage compositions retain the selected containers."
  }
}
