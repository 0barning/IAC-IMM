data "intersight_organization_organization" "org" {
    name = var.organization
}

#####################
# Bios Policy       #
#####################

resource "intersight_bios_policy" "bios_policy1" {
  name                                  = "${var.env}_ESXi_BIOS_Policy"
  description                           = "Performance Settings for ESXi by Terraform"
  cpu_performance                       = "enterprise"
  dram_clock_throttling                 = "Performance"
  direct_cache_access                   = "enabled"
  enhanced_intel_speed_step_tech        = "enabled"
  execute_disable_bit                   = "enabled"
  cpu_frequency_floor                   = "enabled"
  intel_hyper_threading_tech            = "enabled"
  intel_turbo_boost_tech                = "enabled"
  intel_virtualization_technology       = "enabled"
  processor_cstate                      = "disabled"
  processor_c1e                         = "disabled"
  processor_c3report                    = "disabled"
  processor_c6report                    = "disabled"
  cpu_power_management                  = "performance"
  cpu_energy_performance                = "performance"
  intel_vt_for_directed_io              = "enabled"
  numa_optimized                        = "enabled"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  profiles {
    object_type = "server.Profile"
    moid = intersight_server_profile.intersight_server_profile1.moid
  }
}

#####################
# Boot Policy       #
#####################

resource "intersight_boot_precision_policy" "boot_precision1" {
  name                     = "${var.env}_Boot_Policy"
  description              = "ISCSI Boot policy for ESXi hypervisors by Terraform"
  configured_boot_mode     = "Legacy"
  enforce_uefi_secure_boot = true
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  boot_devices {
    enabled     = true
    name        = "A"
    object_type = "boot.Iscsi" 
    additional_properties = jsonencode({
      interface_name = "ESXi_ISCSI_A"
    })
  }
  boot_devices {
    enabled     = true
    name        = "B"
    object_type = "boot.Iscsi"
    additional_properties = jsonencode({
      interface_name = "ESXi_ISCSI_B"
      port = 3260
    })
  }
  boot_devices {
    enabled     = true
    name        = "KVM-DVD"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "kvm-mapped-dvd"
    })
  }
  profiles {
    object_type = "server.Profile"
    moid = intersight_server_profile.intersight_server_profile1.moid
  }
}

#####################
# vMedia Policy     #
#####################

resource "intersight_vmedia_policy" "vmedia1" {
  name          = "${var.env}_vMedia_ESXi67U3_Policy"
  description   = "Automated installation of ESXi 6.0U7 by Terraform"
  enabled       = true
  encryption    = true
  low_power_usb = true
  mappings {
    device_type = "cdd"
    file_location = "http://172.31.113.41/ESXI-6.7.0.update03-14320388.x86_64.iso"
    mount_protocol = "http"
    volume_name = "ESXi-via-HTTP"
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  profiles {
    object_type = "server.Profile"
    moid = intersight_server_profile.intersight_server_profile1.moid
  }
}

############################
# iSCSI Adapter Policy     #
############################

resource "intersight_vnic_iscsi_adapter_policy" "vnic_iscsi_adapter_policy1" {
  name                = "${var.env}_vNic_iSCSI_Adapter_Policy"
  description         = "iSCSI Adapter Policy by Terraform"
  dhcp_timeout        = 60
  connection_time_out = 0
  lun_busy_retry_count = 0
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# Eth Adapter Policy     #
############################

resource "intersight_vnic_eth_adapter_policy" "intersight_vnic_eth_adapter_policy1" {
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }

  name = "${var.env}_vNic_Eth_Adapter_Policy"
  description = "Eth Adapter Policy by Terraformt"

  interrupt_scaling = false
  advanced_filter = false

  vxlan_settings {
    enabled = false
  }

  roce_settings {
    enabled = false
  }

  nvgre_settings {
      enabled = false
  }

  arfs_settings {
    enabled = false
  }

    # Defaults
  uplink_failback_timeout = 5

  completion_queue_settings {
     nr_count = 5
     ring_size = 1
  }

  interrupt_settings {
    nr_count = 8
    coalescing_time = 125
    coalescing_type = "MIN"
    mode = "MSIx"
  }

  rss_settings = true

  rss_hash_settings {
    ipv4_hash = true
    ipv6_ext_hash = false
    ipv6_hash = true
    tcp_ipv4_hash = true
    tcp_ipv6_ext_hash = false
    tcp_ipv6_hash = true
    udp_ipv4_hash = false
    udp_ipv6_hash = false
  }

  rx_queue_settings {
    nr_count = 4
    ring_size = 512
  }

  tx_queue_settings{
    nr_count = 1
    ring_size = 256
  }

  tcp_offload_settings {
    large_receive = true
    large_send = true
    rx_checksum = true
    tx_checksum = true
  }
}

############################
# Network Control Policy   #
############################

resource "intersight_fabric_eth_network_control_policy" "fabric_eth_network_control_policy1" {
  name        = "${var.env}_Network_Control_Policy"
  description = "ESXi Network Control Policy"
  cdp_enabled = true
  forge_mac    = "allow"
  lldp_settings {
    object_type       = "fabric.LldpSettings"
    receive_enabled  = false
    transmit_enabled = true
  }
  mac_registration_mode = "allVlans"
  uplink_fail_action    = "linkDown"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# QoS Policy               #
############################

resource "intersight_vnic_eth_qos_policy" "intersight_vnic_eth_qos_policy1" {
  name           = "${var.env}_Eth_QoS_Policy"
  mtu            = 1500
  rate_limit     = 0
  cos            = 0
  burst          = 10240
  priority       = "Best Effort"
  trust_host_cos = false
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# NTP Policy               #
############################

resource "intersight_ntp_policy" "intersight_ntp_policy1" {
  name    = "${var.env}_NTP_Policy"
  description = "NTP Policy"
  enabled = true
  ntp_servers = [
    "ntp1eu.asml.com",
    "ntp2eu.asml.com",
    "ntp3eu.asml.com",
    "ntp4eu.asml.com"
  ]
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

###############################
# LAN Connectivity Policy     #
###############################

resource "intersight_vnic_lan_connectivity_policy" "intersight_vnic_lan_connectivity_policy1" {
  name             = "${var.env}_LAN_Connectivity_Policy"
  placement_mode = "custom"
  target_platform = "FIAttached"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  profiles {
    object_type = "server.Profile"
    moid = intersight_server_profile.intersight_server_profile1.moid
  }
}

###############################
# Server Template             #
###############################

resource "intersight_server_profile_template" "intersight_server_profile_template1" {
  name             = "${var.env}_Server_Template"
  target_platform = "FIAttached"
  action = "Unassign"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

###############################
# Server Profile              #
###############################

resource "intersight_server_profile" "intersight_server_profile1" {
  name   = "${var.env}_ESXi"
  action = "No-op"
  target_platform = "FIAttached"
  tags {
    key   = "server"
    value = "demo"
  }
 organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# KVM IP Pool              #
############################

resource "intersight_ippool_pool" "intersight_ip_pool1" {
  name             = "${var.env}_KVM_IP_Pool"
  description      = "IP Pool for server KVM console"
  assignment_order = "sequential"
  ip_v4_config {
    gateway     = var.kvmdipgw
    netmask     = var.kvmdipmask
    primary_dns = var.primarydns
    secondary_dns = var.secondarydns
  }
  ip_v4_blocks {
    from        = var.kvmdipfrom
    to          = var.kvmdipto
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# UUID Pool                #
############################

#resource "intersight_uuidpool_pool" "uuidpool_pool1" {
#  name             = "${var.env}_UUID_Pool"
#  description      = "UUID Pool for all devices"
#  assignment_order = "default"
#  prefix           = "123e4567-e89b-42d3"
#  uuid_suffix_blocks {
#    object_type = "uuidpool.UuidBlock"
#    from        = var.uuidfrom
#   #to         = var.uuidto
#    size        = 128
#  }
#  organization {
#    object_type = "organization.Organization"
#    moid        = data.intersight_organization_organization.org.results[0].moid
#  }
#}

############################
# MAC A Pool               #
############################

resource "intersight_macpool_pool" "intersight_macpool_poolA" {
  name = "${var.env}_Mac_Pool_Internal_A"
  description = "Internal MAC Pool for FI A"
  mac_blocks {
    object_type = "macpool.Block"
    from        = var.macafrom
    to          = var.macato
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# MAC B Pool               #
############################

resource "intersight_macpool_pool" "intersight_macpool_poolB" {
  name = "${var.env}_Mac_Pool_Internal_B"
  description = "Internal MAC Pool for FI B"
  mac_blocks {
    object_type = "macpool.Block"
    from        = var.macbfrom
    to          = var.macbto
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}

############################
# IQN Pool                 #
############################
#
#resource "intersight_iqnpool_pool" "iqnpool_pool1" {
#  name             = "${var.env}_IQN_Pool"
#  description      = "IQN Pool"
#  assignment_order = "sequential"
#  prefix           = var.iqnprefix
#  iqn_suffix_blocks {
#    object_type = "iqn.SuffixBlocks"
#    suffix      = var.iqnsuffix
#    from        = "6757"
#    size        = "100"
#  }
#  organization {
#    object_type = "organization.Organization"
#    moid        = data.intersight_organization_organization.org.results[0].moid
#  }
#}

############################
# VLAN ESXi MGMT                #
############################

resource "intersight_fabric_eth_network_group_policy" "intersight_fabric_eth_network_group_policy1" {
  name             = "${var.env}_ESXi_MGMT_VLAN"
  description      = "${var.env} VLANs needed on MGMT interface ESXi"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  # Excluding VLANs for eth0, eth1, and FCoE
  vlan_settings {
      object_type  = "vnic.VlanSettings"
      native_vlan = 1
      allowed_vlans = "11"
  }
}

############################
# VLAN ESXi vMotion        #
############################

resource "intersight_fabric_eth_network_group_policy" "intersight_fabric_eth_network_group_policy2" {
  name             = "${var.env}_ESXi_vMotion_VLAN"
  description      = "${var.env} VLANs needed on vMotion interface ESXi"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  # Excluding VLANs for eth0, eth1, and FCoE
  vlan_settings {
      object_type  = "vnic.VlanSettings"
      native_vlan = 1
      allowed_vlans = "12"
  }
}

############################
# VLAN ESXi VMs            #
############################

resource "intersight_fabric_eth_network_group_policy" "intersight_fabric_eth_network_group_policy3" {
  name             = "${var.env}_ESXi_VM_VLAN"
  description      = "${var.env} VLANs needed for VMson  ESXi"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  # Excluding VLANs for eth0, eth1, and FCoE
  vlan_settings {
      object_type  = "vnic.VlanSettings"
      native_vlan = 1
      allowed_vlans = "11,12,13,14"
  }
}
