#!/bin/bash

if [[ -f ./key ]]; then
  ansible-playbook ansible/k8s-setup.yaml -i ansible/inventory --key-file ./key
else
   echo "ssh key doesn't exist"
fi
