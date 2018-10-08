provider "libvirt" {
  uri = "qemu:///system"
}


module "os-images" {
  source = "./terraform/libvirt/images"
}


resource "libvirt_domain" "domain-ubuntu" {
  name = "${module.os-images.ubuntu-name}"
  memory = "512"
  vcpu = 1

//  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_name = "vm_network"
  }

  # IMPORTANT
  # Ubuntu can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
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

  disk {
       volume_id = "${module.os-images.ubuntu-id}"
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
