provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
}

module "sles" {
  source = "./terraform/libvirt/images/sles/"
}

// we create 4 hosts 

resource "libvirt_volume" "sles12sp3_disk" {
  name = "sles12sp3-${count.index}"
  base_volume_id = "${module.sles.sles_12_sp3_id}"
  pool = "default"
  count = 2
}

resource "libvirt_domain" "sles12sp3" {
  name = "sles12sp3-${count.index}"
  memory = "1024"
  vcpu = 1
  count = 2
  cloudinit = "${module.cloudinit.cloudinit_id}"
  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  disk  {
      volume_id = "${element(libvirt_volume.sles12sp3_disk.*.id, count.index)}"
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
    type = "spice"
    listen_type = "address"
    autoport = true
}

provisioner "local-exec" {
   command = "echo ${self.network_interface.0.addresses.0} > hosts.txt"
}

}
