# ceph-open-terrarium
ceph-open-terrarium let deploy a ceph clust via terraform with saltstack or ansible or other config mgmt tool.


# Design-Architecture:

### Deploy
ceph-open-terrarium will use https://github.com/dmacvicar/terraform-provider-libvirt  for deploying via terraform and cloudinit.

### Config Management:

In roadmap i plan to give support for saltstack and ansible

Ceph related
1) https://github.com/ceph/ceph-ansible
2) https://github.com/SUSE/DeepSea


# Roadmap
### Terraform

0) Create terraform module structures.
1) Create ubuntu/opensuse/fedora etc support images

## Saltstack

Setup minimal config and use deepsea

## Ansible

Reuse as much as possible the ansible-ceph

# Currently under development. Feel free to grab issues for helping! 
