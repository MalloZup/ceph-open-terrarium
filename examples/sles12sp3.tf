provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
}

module "sles" {
  source = "./terraform/libvirt/images/sles/"
}

// NOTE: at moment the count variable need to be the same everywhere.

// volume for ceph 1 disk pro domain

variable "count" {
  default = 4
}

resource "libvirt_volume" "osd_disks" {
  pool   = "default"
  format = "raw"
  name   = "osd_${count.index}_data.raw"
  size   = 100000000
  count  = "${var.count}"
}

// we create 4 hosts 

resource "libvirt_volume" "sles12sp3_disk" {
  name           = "sles12sp3-${count.index}"
  base_volume_id = "${module.sles.sles_12_sp3_id}"
  pool           = "default"
  count          = "${var.count}"
}

resource "libvirt_domain" "sles12sp3" {
  name      = "sles12sp3-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = 4
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  // OS image
  disk {
    volume_id = "${element(libvirt_volume.sles12sp3_disk.*.id, count.index)}"
  }

  // DISK
  disk {
    volume_id = "${element(libvirt_volume.osd_disks.*.id, count.index)}"
  }

  # IMPORTANT
  # you need to pass the console because the image is expecting it as kernel-param.
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
    command = "echo ${self.network_interface.0.addresses.0} >> hosts.txt"
  }
}
