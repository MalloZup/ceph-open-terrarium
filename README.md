# Ceph-open-terrarium
<img src=".doc/pictures/terrarium.jpg" width=250px height=250px>

Ceph-open-terrarium lets deploy a ceph cluster on libvirt-kvm via terraform with saltstack or ansible or any other config mgmt tool.

# Examples:

Have a look at `examples` dir for how to use `ceph-open-terrarium`.

# Design-Architecture:

The architecture of project doesn't mix deployment with config management.
So you will be able to do `terraform apply` for preparing your KVM instances and use the config management of your choice for setup `ceph`

For explanation, remarks about the current Architecture design, have a look here [architecture](ARCHITECTURE.md)

# Contributing:

Take a look on [contributing](CONTRIBUTING.md)

### Deploy:

Deployment will focus on libvirt-kvm.
ceph-open-terrarium will use https://github.com/dmacvicar/terraform-provider-libvirt  for deploying via terraform and cloudinit.

( Due to the modular nature of terraform, we might add terraform for cloud or other providers but for the first releases is out of scope.)

### Config Management:

In roadmap i plan to give support for saltstack and ansible

Ceph related
1) https://github.com/ceph/ceph-ansible
2) https://github.com/SUSE/DeepSea

# Roadmap:

Have a look on the roadmap board under github Projects.
