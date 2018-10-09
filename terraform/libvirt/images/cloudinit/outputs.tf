output "cloudinit_id" {
  value = "${libvirt_cloudinit_disk.cloudinit.id}"
}
