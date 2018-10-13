provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source      = "./terraform/libvirt/images/cloudinit"
  unique_name = "debian9.iso"
}

module "debian" {
  source = "./terraform/libvirt/images/debian/"
}

// we create 4 hosts 

resource "libvirt_volume" "debian_9_disk" {
  name           = "debian9-${count.index}"
  base_volume_id = "${module.debian.debian_9_id}"
  pool           = "default"
  count          = 1
}

resource "libvirt_domain" "debian9" {
  name      = "debian9-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = 1
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${element(libvirt_volume.debian_9_disk.*.id, count.index)}"
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
