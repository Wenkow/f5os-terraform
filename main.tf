provider "f5os" {
  username = var.username
  password = var.password
  host     = var.target1
}

locals {
  vlans_all = merge(var.vlans_external, var.vlans_internal)
}

resource "f5os_vlan" "vlans" {
  for_each = local.vlans_all

  vlan_id = each.value["vlanid"]
  name    = each.key
}

resource "f5os_lag" "TF-LACP-External" {
  name        = "TF-LACP-External"
  members     = ["3.0", "4.0"]
  trunk_vlans = [for vlan in var.vlans_external : vlan.vlanid]
  depends_on  = [f5os_vlan.vlans]
}

resource "f5os_lag" "TF-LACP-Internal" {
  name        = "TF-LACP-Internal"
  members     = ["8.0", "9.0"]
  trunk_vlans = [for vlan in var.vlans_internal : vlan.vlanid]
  depends_on  = [f5os_vlan.vlans]
}

resource "f5os_tenant" "tf-main" {
  name              = "tf-main"
  image_name        = "BIGIP-17.1.1.3-0.0.5.ALL-F5OS.qcow2.zip.bundle"
  mgmt_ip           = "192.168.11.19"
  mgmt_gateway      = "192.168.11.1"
  mgmt_prefix       = 24
  cpu_cores         = 8
  memory            = 36864
  vlans             = [for vlan in local.vlans_all : vlan.vlanid]
  running_state     = "deployed"
  virtual_disk_size = 82
  depends_on        = [f5os_lag.TF-LACP-External, f5os_lag.TF-LACP-Internal]
}

