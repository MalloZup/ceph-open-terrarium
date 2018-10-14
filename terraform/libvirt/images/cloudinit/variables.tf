variable "pool" {
  description = "libvirt storage pool name for VM disks"
  default     = "default"
}

variable "unique_name" {
  description = "unique name for the cloudint image"
  default     = "cloudinit.iso"
}

variable "cloudinit_filename" {
  description = "filename of cloudinit"
  default     = "cloud_init_default.cfg"
}
