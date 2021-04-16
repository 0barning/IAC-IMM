data "intersight_organization_organization" "org" {
    name = var.organization
}

resource "intersight_hyperflex_vcenter_config_policy" "hyperflex_vcenter_config_policy1" {
  hostname    = "vcenter.workload.local"
  username    = "administrator@workload.local"
  password    = var.password
  data_center = "WLT"
  sso_url     = ""
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "HyperFlex_vCenter_Policy"
  description = "Created by Terraform"
}