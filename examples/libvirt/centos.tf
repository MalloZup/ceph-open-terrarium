provider "libvirt" {
  uri = "qemu:///system"
}

module "centos" {
  source = "./terraform/libvirt/images/centos"
}

module "cloudinit" {
  source      = "./terraform/libvirt/images/cloudinit"
  unique_name = "centos7_cloudinit.iso"
}

// Create 4 instances
variable "count" {
  default = 4
}

resource "libvirt_volume" "centos_disk" {
  name           = "centos7-${count.index}"
  base_volume_id = "${module.centos.centos_7_id}"
  pool           = "default"
  count          = "${var.count}"
}

resource "libvirt_volume" "osd_disks" {
  pool   = "default"
  format = "raw"
  name   = "osd_${count.index}_data.raw"
  count  = "${var.count}"
}

resource "libvirt_domain" "centos7" {
  name      = "centos7-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = "${var.count}"
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  // Disk containing OS
  disk {
    volume_id = "${element(libvirt_volume.centos_disk.*.id, count.index)}"
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

  provisioner "local-exec" {
    command = "echo ${self.network_interface.0.addresses.0} >> hosts_centos7.txt"
  }
}
