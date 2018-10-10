# Design Architecture:

## Components:

This project use following components:

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


Terraform apply will just creating your instances on KVM.
You need to provisioning them via salt or ansible.

You can still wrap this 2 operation in your customs CI scripts if you wish.

Separating this 2 operatin will bring more benifits for maintaining the whole stack.

## Terraform v12:

https://www.hashicorp.com/blog/terraform-0-1-2-preview

With the new major release of v12 there are several changes on terraform hcl.


For this reason i prefer to use plain hcl and redundant code, instead of having complexity and loops which will because of the major release need to readapted.

The golden rule at moment for modules is to add them only for OS images.

# About the cloudinit module:

The cloudinit module will generate the same iso for your host.

At moment if you have 3 different main.tf on same hosts, you will have an error because if will create the same iso with same name 3 times. ( if you include the cloudinit module).

I up to the user to don\t include it. ( or we might find another design)

# About modules:

I choosed to implement only images as modules and let the people free on implement the rest of logic with HCL language.

In this way we rest flexible for changes in the terraform api upstream and the libvirt-plugin.

