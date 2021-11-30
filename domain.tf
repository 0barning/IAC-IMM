resource "intersight_fabric_switch_cluster_profile" "fabric_switch_cluster_profile1" {
  name        = "fabric_switch_cluster_profile"
  description = "demo fabric switch cluster profile"
  type        = "instance"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

resource "intersight_chassis_profile" "chassis_profile1" {
  name            = "chassis_profile1"
  description     = "chassis profile"
  type            = "instance"
  target_platform = "FIAttached"
  action          = "Validate"
  config_context {
    object_type    = "policy.ConfigContext"
    control_action = "deploy"
    error_state    = "Validation-error"
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}