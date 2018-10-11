#! /bin/bash

# we call this script inside the .ci dir

set -e

cd ..
if [ `terraform fmt | wc -c` -ne 0 ]; then echo "terraform files need be formatted! run terraform fmt!"; exit 1; fi
cd .ci/

cd ../examples
for file in "."/*
do
  if [ ! -d "$file" ]; then
	echo $file
	cp $file ../main.tf
	cd ..
	terraform init
	terraform validate
	terraform plan
	cd examples
  fi
done
