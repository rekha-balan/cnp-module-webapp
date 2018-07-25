output "webapp_name" {
  value = "${azurerm_template_deployment.app_service_site.name}"
}

output "gitendpoint" {
  value = "${azurerm_template_deployment.app_service_site.name}.scm.service.core-compute-prod.internal/${azurerm_template_deployment.app_service_site.name}.git"
}

output "url" {
  value = "http://${azurerm_template_deployment.app_service_site.name}.service.internal"
}

output "resource_group_name" {
  value = "${azurerm_resource_group.rg.name}"
}

output "staging_app_settings" {
  value = "${jsonencode(merge(var.staging_slot_app_settings, var.app_settings_defaults, local.app_settings_evaluated, var.app_settings))}"
}
