provider "libvirt" {
  uri = "qemu:///system"
}


module "os-images" {
  source = "./terraform/libvirt/images"
}
