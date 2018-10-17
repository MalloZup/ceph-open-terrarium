# How to contribute.

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
