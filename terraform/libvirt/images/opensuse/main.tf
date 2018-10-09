terraform {
    required_version = "~> 0.11.7"
}
resource "libvirt_volume" "opensuse_423_volume" {
  name = "opensuse_423"
  source = "http://download.opensuse.org/repositories/Cloud:/Images:/Leap_42.3/images/openSUSE-Leap-42.3-OpenStack.x86_64.qcow2"
  count = "1"
  pool = "${var.pool}"
}
