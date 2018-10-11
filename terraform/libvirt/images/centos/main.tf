terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "centos_7_volume" {
  name   = "centos_7"
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
