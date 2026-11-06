# Keep these declarations so Terraform can follow existing production objects
# when the portal resource group and Static Web App move into the shared module.
moved {
  from = azurerm_resource_group.web_production
  to   = module.workforce_portal.azurerm_resource_group.web_nonproduction
}

moved {
  from = azurerm_static_web_app.workforce_portal
  to   = module.workforce_portal.azurerm_static_web_app.workforce_portal
}

moved {
  from = azurerm_resource_group.connectivity_production
  to   = module.network.azurerm_resource_group.network_nonproduction
}

moved {
  from = azurerm_virtual_network.workforce_spoke_production
  to   = module.network.azurerm_virtual_network.app_nonproduction
}

moved {
  from = azurerm_subnet.functions_integration
  to   = module.network.azurerm_subnet.functions_integration
}

moved {
  from = azurerm_subnet.private_endpoints
  to   = module.network.azurerm_subnet.private_endpoints
}

moved {
  from = azurerm_resource_group.data_production
  to   = module.sql.azurerm_resource_group.data_nonproduction
}

moved {
  from = azurerm_mssql_server.workforce
  to   = module.sql.azurerm_mssql_server.workforce
}

moved {
  from = azurerm_mssql_database.workforce
  to   = module.sql.azurerm_mssql_database.workforce
}

moved {
  from = azurerm_private_dns_zone.sql
  to   = module.sql.azurerm_private_dns_zone.sql
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.sql_app_vnet
  to   = module.sql.azurerm_private_dns_zone_virtual_network_link.sql_app_vnet
}

moved {
  from = azurerm_private_endpoint.sql_server
  to   = module.sql.azurerm_private_endpoint.sql_server
}

moved {
  from = azurerm_resource_group.documents_production
  to   = module.storage.azurerm_resource_group.docs_nonproduction
}

moved {
  from = azurerm_storage_account.docs
  to   = module.storage.azurerm_storage_account.docs
}

moved {
  from = azurerm_storage_container.docs
  to   = module.storage.azurerm_storage_container.docs
}

moved {
  from = azurerm_monitor_diagnostic_setting.docs_blob_service
  to   = module.storage.azurerm_monitor_diagnostic_setting.docs_blob_service
}

moved {
  from = azurerm_role_assignment.docs_admins_blob_data_owner
  to   = module.storage.azurerm_role_assignment.docs_admins_blob_data_owner
}

moved {
  from = azurerm_role_assignment.docs_contributors_blob_data_contributor
  to   = module.storage.azurerm_role_assignment.docs_contributors_blob_data_contributor
}

moved {
  from = azurerm_role_assignment.docs_readers_blob_data_reader
  to   = module.storage.azurerm_role_assignment.docs_readers_blob_data_reader
}

moved {
  from = azuread_group.workforce_admins
  to   = module.identity.azuread_group.workforce_admins
}

moved {
  from = azuread_app_role_assignment.workforce_admins_api_admin
  to   = module.identity.azuread_app_role_assignment.workforce_admins_api_admin
}

moved {
  from = azuread_group.workforce_supervisors
  to   = module.identity.azuread_group.workforce_supervisors
}

moved {
  from = azuread_app_role_assignment.workforce_supervisors_api_supervisor
  to   = module.identity.azuread_app_role_assignment.workforce_supervisors_api_supervisor
}

moved {
  from = azuread_group.workforce_caregivers
  to   = module.identity.azuread_group.workforce_caregivers
}

moved {
  from = azuread_app_role_assignment.workforce_caregivers_api_caregiver
  to   = module.identity.azuread_app_role_assignment.workforce_caregivers_api_caregiver
}

moved {
  from = azuread_group.workforce_hr
  to   = module.identity.azuread_group.workforce_hr
}

moved {
  from = azuread_app_role_assignment.workforce_hr_api_hr
  to   = module.identity.azuread_app_role_assignment.workforce_hr_api_hr
}

moved {
  from = azuread_group.workforce_sensitive_onboarding
  to   = module.identity.azuread_group.workforce_sensitive_onboarding
}

moved {
  from = azuread_app_role_assignment.workforce_sensitive_onboarding_api_sensitive_onboarding
  to   = module.identity.azuread_app_role_assignment.workforce_sensitive_onboarding_api_sensitive_onboarding
}

moved {
  from = azuread_group.workforce_payroll[0]
  to   = module.identity.azuread_group.workforce_payroll
}

moved {
  from = azuread_app_role_assignment.workforce_payroll_api_payroll[0]
  to   = module.identity.azuread_app_role_assignment.workforce_payroll_api_payroll
}

moved {
  from = azurerm_storage_account.stage2_document_intake
  to   = module.stage2.azurerm_storage_account.stage2_document_intake
}

moved {
  from = azurerm_storage_container.stage2_document_intake
  to   = module.stage2.azurerm_storage_container.stage2_document_intake
}

moved {
  from = azurerm_storage_container.gmail_document_quarantine
  to   = module.stage2.azurerm_storage_container.gmail_document_quarantine
}

moved {
  from = azurerm_storage_container.stage2_document_scan_deadletter
  to   = module.stage2.azurerm_storage_container.stage2_document_scan_deadletter
}

moved {
  from = azurerm_monitor_diagnostic_setting.stage2_document_intake_blob_service
  to   = module.stage2.azurerm_monitor_diagnostic_setting.stage2_document_intake_blob_service
}

moved {
  from = azurerm_monitor_diagnostic_setting.stage2_document_intake_queue_service
  to   = module.stage2.azurerm_monitor_diagnostic_setting.stage2_document_intake_queue_service
}

moved {
  from = azurerm_function_app_flex_consumption.workforce_api
  to   = module.workforce_api.azurerm_function_app_flex_consumption.workforce_api
}

moved {
  from = azurerm_storage_queue.applicant_confirmation_email
  to   = module.messaging.azurerm_storage_queue.applicant_confirmation_email
}

moved {
  from = azurerm_communication_service.workforce
  to   = module.messaging.azurerm_communication_service.workforce
}

moved {
  from = azurerm_email_communication_service.workforce
  to   = module.messaging.azurerm_email_communication_service.workforce
}

moved {
  from = azurerm_email_communication_service_domain.azure_managed
  to   = module.messaging.azurerm_email_communication_service_domain.azure_managed
}

moved {
  from = azurerm_communication_service_email_domain_association.workforce
  to   = module.messaging.azurerm_communication_service_email_domain_association.workforce
}

moved {
  from = azurerm_role_assignment.function_app_confirmation_queue_contributor
  to   = module.messaging.azurerm_role_assignment.function_app_confirmation_queue_contributor
}

moved {
  from = azurerm_role_assignment.function_app_communication_email_owner
  to   = module.messaging.azurerm_role_assignment.function_app_communication_email_owner
}

moved {
  from = azurerm_storage_queue.notice_email_delivery
  to   = module.messaging.azurerm_storage_queue.notice_email_delivery
}

moved {
  from = azurerm_storage_queue.notice_email_delivery_poison
  to   = module.messaging.azurerm_storage_queue.notice_email_delivery_poison
}

moved {
  from = azurerm_storage_queue.stage2_invitation_email
  to   = module.messaging.azurerm_storage_queue.stage2_invitation_email
}
