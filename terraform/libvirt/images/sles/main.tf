terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "sles_12_sp3" {
  name   = "sles12_sp3"
  source = "http://download.suse.de/install/SLE-12-SP3-JeOS-GM/SLES12-SP3-JeOS-for-OpenStack-Cloud.x86_64-GM.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}

resource "libvirt_volume" "sles_15" {
  name   = "sles_15"
  source = "http://download.suse.de/install/SLE-15-JeOS-GM/SLES15-JeOS.x86_64-15.0-OpenStack-Cloud-GM.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
