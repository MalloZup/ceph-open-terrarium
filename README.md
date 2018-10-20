# Ceph-open-terrarium
<img src=".doc/pictures/terrarium.jpg" width=250px height=250px>


[![Build Status](https://travis-ci.org/MalloZup/ceph-open-terrarium.svg?branch=master)](https://travis-ci.org/MalloZup/ceph-open-terrarium)
[![Gitter chat](https://badges.gitter.im/ceph-open-terrarium/Lobby.png)](https://gitter.im/ceph-open-terrarium/Lobby)
[![Code of Conduct](https://img.shields.io/badge/code%20of-conduct-lightgrey.svg)][coc]
[![Roadmap](https://img.shields.io/badge/Roadmap-%20-brightgreen.svg)](https://github.com/MalloZup/ceph-open-terrarium/projects/1)
___

## Table of Content

- [Install](#install)
- [Examples](#examples)
- [Design Architecture of Project](#design-architecture)
- [Deploy](#deploy)
- [Config Management](#config-management)
- [Contributing](#contributing)
- [Opensource Distros Supported](#opensource-distros-avaible)
___

# Motivation:

Deploy a ceph cluster with terraform `backends` and provisioning with config management tools.

Currently we support following terraform `backends`:
*  `libvirt` terraform-plugin. (https://github.com/dmacvicar/terraform-provider-libvirt)

Currently we support following provisioning tools:

* saltstack.
* ansible.

# Install:

You need to install terraform  https://www.terraform.io/ and https://github.com/dmacvicar/terraform-provider-libvirt.

For the config management you will need to have saltstack or ansible installed on the machine executing the states/playbook.

# Examples:

Have a look at [examples](https://github.com/MalloZup/ceph-open-terrarium/tree/master/examples)

# Design-Architecture:

For explanation, remarks about the current Architecture design, have a look here [architecture](ARCHITECTURE.md)

# Deploy:

Take an example.tf file and run `terraform apply`

Deployment will focus on libvirt-kvm.
ceph-open-terrarium will use https://github.com/dmacvicar/terraform-provider-libvirt  for deploying via terraform and cloudinit.

( Due to the modular nature of terraform, we might add terraform for cloud or other providers but for the first releases is out of scope.)

# Config Management:

### The saltstack way:

Follow instruction here:
https://github.com/MalloZup/ceph-open-terrarium/tree/master/salt


### The ansible way:

Once you have the IPs adress of the virtual hosts, you can use ansible.
For ansible, have a look at upstream doc https://github.com/ceph/ceph-ansible

# Opensource distros avaible

You can use following OS-images.
Note: We are providing the OS-images, feel free to fix/expand the terraform files and relative modules.

**Requirements:** For adding an OS on the table we need a cloud-image avaible upstream.


| Operating System             | Version    |  Avaible           | To be supported (see requirements) | Backend    |
| ---------------------------- | :--------: | :----------------: | :---------------: | libvirt    |
| Arch                         | latest     | :heavy_check_mark: |                   | libvirt    |
| openSUSE                     | Leap 42.3  | :heavy_check_mark: |                   | libvirt    |
| Ubuntu                       | 18.04      | :heavy_check_mark: |                   | libvirt    |
| CentOS                       | 7.1        | :heavy_check_mark: |                   | libvirt    |
| Debian                       | 9          | :heavy_check_mark: |                   | libvirt    |
| Fedora                       | 28         | :heavy_check_mark: |                   | libvirt    |
| Gentoo                       |            |                    | :no_entry:        | libvirt    |

There are Linux Entreprise System however this images are not open to community.

# Contributing:

Take a look on [contributing](CONTRIBUTING.md)


# Authors:

- [Dario Maiocchi](https://github.com/MalloZup)

A big  thank you to all  [contributors](https://github.com/MalloZup/ceph-open-terrarium/graphs/contributors) who participated in this project.


[coc-badge]: https://img.shields.io/badge/code%20of-conduct-ff69b4.svg?style=for-the-badge

[coc]:https://github.com/MalloZup/ceph-open-terrarium/blob/master/CODE_OF_CONDUCT.md "Contributor Covenant Code of Conduct"
