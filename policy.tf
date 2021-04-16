data "intersight_organization_organization" "org" {
    name = var.organization
}



resource "intersight_server_profile" "IMM-ESXi-02" {
  name   = "IMM-ESXi-02"
  action = "No-op"
  target_platform = "FIAttached"

  tags {
    key   = "deployment_type"
    value = "terraform"
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}