provider "libvirt" {
  uri = "qemu:///system"
}

module "centos" {
  source = "./terraform/libvirt/images/centos"
}

module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
}

resource "libvirt_volume" "centos_disk" {
  name = "opensuse423-${count.index}"
  base_volume_id = "${module.centos.centos_7_id}"
  pool = "default"
  count = 1
}


// this example create 2 instances
resource "libvirt_domain" "centos7" {
  name = "centos7-${count.index}"
  memory = "1024"
  vcpu = 1
  count = 1
  cloudinit = "${module.cloudinit.cloudinit_id}"
  network_interface {
    network_name = "default"
  }

  disk  {
      volume_id = "${element(libvirt_volume.centos_disk.*.id, count.index)}"
   }
}
