terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "archlinux_volume" {
  name   = "archlinux"
  source = "https://linuximages.de/openstack/arch/arch-openstack-LATEST-image-bootstrap.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
