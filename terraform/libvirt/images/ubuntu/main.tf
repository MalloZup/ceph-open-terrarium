terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "ubuntu_1804_volume" {
  name   = "ubuntu_1804"
  source = "https://cloud-images.ubuntu.com/releases/18.04/release/ubuntu-18.04-server-cloudimg-amd64.img"
  count  = "1"
  pool   = "${var.pool}"
}
