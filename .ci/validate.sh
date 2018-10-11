#! /bin/bash

set -e

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
