#!/bin/bash

if [[ -f ./key ]]; then
  if [ -z "$1" ]; then
    ansible-playbook ansible/k8s-setup.yaml -i ansible/inventory --key-file ./key
  else
    ansible-playbook ansible/k8s-setup.yaml -i ansible/inventory --key-file ./key --tags $1
  fi
else
   echo "ssh key doesn't exist"
fi
