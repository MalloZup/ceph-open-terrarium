#! /bin/bash

# we call this script inside the .ci dir

set -ex

cd examples/
if [ `terraform fmt | wc -c` -ne 0 ]; then echo "terraform files need be formatted! run terraform fmt!"; exit 1; fi
cd libvirt

for file in "."/*
do
  if [ ! -d "$file" ]; then
	echo $file
	cp $file ../../main.tf
	cd ../..
	terraform init
	# validate libvirt examples
	echo $PWD
	cd examples/libvirt
  fi
done
