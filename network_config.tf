############################
# ESXi_MGMT_A              #
############################

resource "intersight_vnic_eth_if" "ESXi_MGMT_A" {
    name = "ESXi_MGMT_A"
 #   description = "ESXi Management Interface Fabric A"
    order = 0
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolA.moid
    }

    placement {
        id = "MLOM"
        switch_id = "A"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_MGMT_A"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy1.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

############################
# ESXi_MGMT_B              #
############################

resource "intersight_vnic_eth_if" "ESXi_MGMT_B" {
    name = "ESXi_MGMT_B"
#    description = "ESXi Management Interface Fabric A"
    order = 2
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolB.moid
    }

    placement {
        id = "MLOM"
        switch_id = "B"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_MGMT_B"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy1.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

############################
# ESXi_UPLINK_A            #
############################

resource "intersight_vnic_eth_if" "ESXi_UPLINK_A" {
    name = "ESXi_UPLINK_A"
#    description = "Tenant VM Uplink Fabric A"
    order = 3
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolA.moid
    }

    placement {
        id = "MLOM"
        switch_id = "A"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_UPLINK_A"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy3.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

############################
# ESXi_UPLINK_B            #
############################

resource "intersight_vnic_eth_if" "ESXi_UPLINK_B" {
    name = "ESXi_UPLINK_B"
#    description = "Tenant VM Uplink Fabric A"
    order = 4
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolB.moid
    }

    placement {
        id = "MLOM"
        switch_id = "B"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_UPLINK_B"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy3.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

############################
# ESXi_VMOTION_A            #
############################

resource "intersight_vnic_eth_if" "ESXi_VMOTION_A" {
    name = "ESXi_VMOTION_A"
    order = 5
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolA.moid
    }

    placement {
        id = "MLOM"
        switch_id = "A"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_VMOTION_A"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy2.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

############################
# ESXi_VMOTION_B           #
############################

resource "intersight_vnic_eth_if" "ESXi_VMOTION_B" {
    name = "ESXi_VMOTION_B"
    order = 6
    mac_address_type = "POOL"

    mac_pool {
      moid = intersight_macpool_pool.intersight_macpool_poolB.moid
    }

    placement {
        id = "MLOM"
        switch_id = "B"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "ESXi_VMOTION_B"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy1.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy1.moid
    }

    fabric_eth_network_group_policy {
        moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy2.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy1.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}