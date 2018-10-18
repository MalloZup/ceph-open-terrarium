# How to contribute.

This guide will show you how to contribute on this project.

# Contribute on other tools:

You can contribute on the single terraform-provider used or also on the software components used by this project :).

# Contribute on saltstack states:

If you want to contribute on saltstack states, as golden rule try don't use `cmd.run` when possible use official states.


# Contribute on terraform

If you want to create a new backend for terraform like use `cloud`, `vmware` etc, follow this rules:

* Add a new dir for modules needed from backend.

` terraform/openstack/`

* Create images modules (only).

* Separate provisioning from deploy. 
( the backend should only deploy, with no scripts execution, this is saltstack or ansible job).

* Use upstream images (openSUSE, Fedora, Ubuntu, Debian, etc).

* Add documentation and examples. 

 For examples add e.g `examples/openstack` if you are doing the openstack backend.


# Extending images modules:

When you add a new module, take care to add examples and documentation for it.

At this moment, we only have module for images and I think this is the best way for it.


## Create a new module for images:

Except for the `cloudinit` module, the images are ordered by family:

`centos  cloudinit  opensuse  sles  ubuntu`.

So if you want to add a new family, add a directory with same structure of modules.

### Conventions:

Use underscores everywhere `_`.

```hcl
output "opensuse_423_id" {
  value = "${libvirt_volume.opensuse_423_volume.id}"
}
```
```hcl
output "centos_7_id" {
  value = "${libvirt_volume.centos_7_volume.id}"
}
```

For os names, the convention is: `OS_NAME` +`_` + `MAJOR_VERSION` + `+ `_`+ `SERVICE_PACK/MinorVersion
