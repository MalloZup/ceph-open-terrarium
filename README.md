# Ceph-open-terrarium
<img src=".doc/pictures/terrarium.jpg" width=250px height=250px>


[![Build Status](https://travis-ci.org/MalloZup/ceph-open-terrarium.svg?branch=master)](https://travis-ci.org/MalloZup/ceph-open-terrarium)
[![Gitter chat](https://badges.gitter.im/ceph-open-terrarium/Lobby.png)](https://gitter.im/ceph-open-terrarium/Lobby)
[![Code of Conduct][coc-badge]][coc]


Ceph-open-terrarium lets deploy a ceph cluster on libvirt-kvm via terraform with saltstack or ansible or any other config mgmt tool.

# Install:

You need to install terraform  https://www.terraform.io/ and https://github.com/dmacvicar/terraform-provider-libvirt.

For the config management you will need to have saltstack or ansible installed on the machine executing the states/playbook.

# Examples:

Have a look at `examples` dir for how to use `ceph-open-terrarium`.

# Design-Architecture:

The architecture of project doesn't mix deployment with config management.
So you will be able to do `terraform apply` for preparing your KVM instances and use the config management of your choice for setup `ceph`

For explanation, remarks about the current Architecture design, have a look here [architecture](ARCHITECTURE.md)

## Deploy:

Take an example.tf file and run `terraform apply`

Deployment will focus on libvirt-kvm.
ceph-open-terrarium will use https://github.com/dmacvicar/terraform-provider-libvirt  for deploying via terraform and cloudinit.

( Due to the modular nature of terraform, we might add terraform for cloud or other providers but for the first releases is out of scope.)

## Config Management:

### The saltstack way:

Follow instruction here:
https://github.com/MalloZup/ceph-open-terrarium/tree/master/salt
This will then setup the requirements for deepSea.

https://github.com/SUSE/DeepSea

### The ansible way:

Once you have the IPs adress of the virtual hosts, you can use ansible.
For ansible, have a look at upstream doc https://github.com/ceph/ceph-ansible

# Roadmap:

Have a look on the roadmap board under github Projects.

# Supported/Avaible Operating Systems

You can use following OS-images.
Note: We are providing the OS-images, feel free to fix/expand the terraform files and relative modules.


| Operating System             | Version    |  Avaible           | Not Supported Yet |
| ---------------------------- | :--------: | :----------------: | :---------------: |
| Arch                         | latest     | :heavy_check_mark: |                   |
| openSUSE                     | Leap 42.3  | :heavy_check_mark: |                   |
| Ubuntu                       | 18.04      | :heavy_check_mark: |                   |
| CentOS                       | 7.1        | :heavy_check_mark: |                   |
| Debian                       | 9          | :heavy_check_mark: |                   |
| Fedora                       | 28         | :heavy_check_mark: |                   |
| Gentoo                       |            |                    | :no_entry:        |
| Red Hat Enterprise Linux     |            |                    | :no_entry:        |
| Deepin                       |            |                    | :no_entry:        |
| SUSE Linux Enterprise Server | 12 SP3     | :heavy_check_mark: |                   |

# Contributing:

Take a look on [contributing](CONTRIBUTING.md)

# Authors:

- [Dario Maiocchi](https://github.com/MalloZup)

See also the list of [contributors](https://github.com/MalloZup/ceph-open-terrarium/graphs/contributors) who participated in this project.


[coc-badge]: https://img.shields.io/badge/code%20of-conduct-ff69b4.svg?style=for-the-badge

[coc]:https://github.com/MalloZup/ceph-open-terrarium/blob/master/CODE_OF_CONDUCT.md "Contributor Covenant Code of Conduct"
