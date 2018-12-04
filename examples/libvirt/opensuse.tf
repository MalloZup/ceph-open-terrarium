provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source      = "./terraform/libvirt/images/cloudinit"
  unique_name = "opensuse_jeos_cloudinit.iso"
}

module "opensuse" {
  source = "./terraform/libvirt/images/opensuse/"
}

// Create 4 instances
variable "count" {
  default = 4
}

resource "libvirt_volume" "osd_disks" {
  pool   = "default"
  format = "raw"
  name   = "osd_${count.index}_data.raw"
  count  = "${var.count}"
}

resource "libvirt_volume" "opensuse_disk" {
  name           = "opensuse423-${count.index}"
  base_volume_id = "${module.opensuse.opensuse_423_id}"
  pool           = "default"
  count          = "${var.count}"
}

resource "libvirt_domain" "opensuse423" {
  name      = "opensuse423-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = "${var.count}"
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  //Disk containing OS
  disk {
    volume_id = "${element(libvirt_volume.opensuse_disk.*.id, count.index)}"
  }

  // Empty DISK data
  disk {
    volume_id = "${element(libvirt_volume.osd_disks.*.id, count.index)}"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
