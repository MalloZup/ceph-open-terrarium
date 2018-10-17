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


Terraform apply will just create your instances on KVM and also create DISK/Volumes on demand.

You will need to provision your infrastructure via salt or ansible.

You can still wrap these two operations in your customs CI scripts if you wish.

Separating this 2 operations will have more benefits in maintaining the whole stack.

## Terraform v12:

https://www.hashicorp.com/blog/terraform-0-1-2-preview

With the new major release of v12, there are several changes on terraform hcl.


For this reason I prefer to use plain hcl and redundant code, instead of having complexity and loops which will need to be readapted due to the major release.

The golden rule at the moment for modules is to add them only for OS images.

# About modules:

I chose to implement only the images as modules and let the others implement the rest of the logic with HCL language.

In this way we can rest the flexibility for changes in the terraform api upstream and the libvirt-plugin.

# SSH-KEYS:

The cloudinit inject the public key present in `ssh_key` directory.

This ssh-key is also used by saltstack and can be used by other tools.

Use only that key.

