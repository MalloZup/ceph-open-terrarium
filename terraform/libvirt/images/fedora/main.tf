terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "fedora_28_volume" {
  name   = "fedora_28"
  source = "https://download.fedoraproject.org/pub/fedora/linux/releases/28/Cloud/x86_64/images/Fedora-Cloud-Base-28-1.1.x86_64.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
