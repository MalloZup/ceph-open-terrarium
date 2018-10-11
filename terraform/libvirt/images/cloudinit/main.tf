terraform {
  required_version = "~> 0.11.7"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "cloudinit.iso"
  user_data = "${data.template_file.user_data.rendered}"
}
