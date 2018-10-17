provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
  unique_name        = "opensuse_jeos_cloudinit.iso"
}

module "opensuse" {
  source = "./terraform/libvirt/images/opensuse/"
}

// we create 4 hosts 

resource "libvirt_volume" "opensuse_disk" {
  name           = "opensuse423-${count.index}"
  base_volume_id = "${module.opensuse.opensuse_423_id}"
  pool           = "default"
  count          = 1
}

resource "libvirt_domain" "opensuse423" {
  name      = "opensuse423-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = 1
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${element(libvirt_volume.opensuse_disk.*.id, count.index)}"
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
