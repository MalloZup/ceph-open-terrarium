# Design Architecture:

## Components:

This project uses the following components:

* terraform-libvirt-provider:
https://github.com/dmacvicar/terraform-provider-libvirt

* cloudinit:
https://cloudinit.readthedocs.io/en/latest/

* terraform,

* saltstack,  ansible

## Design decisions:

You need to do 2 **separate** operations: 

1) `terraform apply` for deploy
2) and salt/ansible provisioning. 


Terraform apply will just create your instances on KVM.
You need to provision them via salt or ansible.

You can still wrap these two operations in your customs CI scripts if you wish.

Separating this 2 operations will have more benefits in maintaining the whole stack.

## Terraform v12:

https://www.hashicorp.com/blog/terraform-0-1-2-preview

With the new major release of v12, there are several changes on terraform hcl.


For this reason I prefer to use plain hcl and redundant code, instead of having complexity and loops which will need to be readapted due to the major release.

The golden rule at the moment for modules is to add them only for OS images.

# About the cloudinit module:

The cloudinit module will generate the same iso for your host.

At the moment if you have 3 different main.tf on the same hosts, you will have an error because it will create the same iso with the  same name three times ( if you include the cloudinit module).

It is up to the user to include it or not (they could also find another design).

# About modules:

I chose to implement only the images as modules and let the others implement the rest of the logic with HCL language.

In this way we can rest the flexibility for changes in the terraform api upstream and the libvirt-plugin.

