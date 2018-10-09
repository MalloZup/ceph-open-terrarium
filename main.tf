provider "libvirt" {
  uri = "qemu:///system"
}

//  You can remove module if you don\t use a specific os
//  or you can add/implement a new one.

// download opensuse images
module "opensuse" {
  source = "./terraform/libvirt/images/opensuse/"
}

// download opensuse images
module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
}


// 0: for entreprise Linux, you need to implement a custom module images. 


// 1: opensource Linux 

// for the resource paramaters, have look here:
// https://github.com/dmacvicar/terraform-provider-libvirt#website-docs 


// ** opensuse423 example:

// this example create 2 instances
resource "libvirt_domain" "opensuse423" {
  name = "opensuse423-${count.index}"
  memory = "1024"
  vcpu = 1
  count = 2
  cloudinit = "${module.cloudinit.cloudinit_id}"
  network_interface {
    network_name = "default"
  }
 
  disk {
       volume_id = "${module.opensuse.opensuse_423_id}"
  }
}
