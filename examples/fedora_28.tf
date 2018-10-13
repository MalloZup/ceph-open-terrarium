provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source      = "./terraform/libvirt/images/cloudinit"
  unique_name = "fedora-cloudinit.iso"
}

module "fedora" {
  source = "./terraform/libvirt/images/fedora/"
}

resource "libvirt_volume" "fedora_28_disk" {
  name           = "fedora28-${count.index}"
  base_volume_id = "${module.archlinux.archlinux_id}"
  pool           = "default"
  count          = 1
}

resource "libvirt_domain" "fedora_28" {
  name      = "fedora28-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = 1
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${element(libvirt_volume.fedora_28_disk.*.id, count.index)}"
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
