terraform {
    required_version = "~> 0.11.7"
}

resource "libvirt_volume" "centos7_volume" {
  name = "centos7"
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  count = "1"
  pool = "${var.pool}"
}

resource "libvirt_volume" "opensuse423_volume" {
  name = "opensuse423"
  source = "http://download.opensuse.org/repositories/Cloud:/Images:/Leap_42.3/images/openSUSE-Leap-42.3-OpenStack.x86_64.qcow2"
  count = "1"
  pool = "${var.pool}"
}

resource "libvirt_volume" "ubuntu-1804_volume" {
  name = "ubuntu-1804"
  source = "https://cloud-images.ubuntu.com/releases/18.04/release/ubuntu-18.04-server-cloudimg-amd64.img"
  count = "1"
  pool = "${var.pool}"
}
