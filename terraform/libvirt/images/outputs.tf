output "ubuntu-name" {
  value = "${libvirt_volume.ubuntu-1804_volume.name}"
}

output "ubuntu-id" {
  value = "${libvirt_volume.ubuntu-1804_volume.id}"
}
