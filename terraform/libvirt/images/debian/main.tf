terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "debian_9_volume" {
  name   = "debian_9"
  source = "http://cdimage.debian.org/cdimage/openstack/current-9/debian-9-openstack-amd64.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
