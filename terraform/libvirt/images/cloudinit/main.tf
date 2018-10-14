terraform {
  required_version = "~> 0.11.7"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/${var.cloudinit_filename}")}"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "${var.unique_name}"
  user_data = "${data.template_file.user_data.rendered}"
  pool      = "${var.pool}"
}
