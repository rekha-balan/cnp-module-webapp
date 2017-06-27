resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-${var.name}"
  location = "${var.location}"
}

data "template_file" "sitetemplate" {
  template = "${file("${path.module}/templates/asp-app.json")}"
}

# Create Application Service site
resource "azurerm_template_deployment" "app_service_site" {
  template_body       = "${data.template_file.sitetemplate.rendered}"
  name                = "${var.env}-${var.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  deployment_mode     = "Incremental"

  parameters = {
    name                  = "${var.env}-${var.name}"
    aseName               = "${data.terraform_remote_state.moj_core_infrastructure.ase_name[0]}"
    stagingSlotName       = "${var.env}-${var.name}-${var.stagingslotname}"
    lastKnownGoodSlotName = "${var.env}-${var.name}-${var.lastknowngoodslotname}"
    location              = "${var.location}"
    env                   = "${var.env}"
  }
}

# TODO refactor outputs once module is extracted
output "gitendpoint" {
  value = "${var.env}-${var.name}.scm.${var.env}-${var.name}.p.azurewebsites.net/${var.env}-${var.name}.git"
}
