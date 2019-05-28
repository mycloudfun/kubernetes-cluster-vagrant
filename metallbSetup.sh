#!/bin/bash
KUBECONFIG=ansible/buffer/admin.conf

kubectl --kubeconfig=$KUBECONFIG apply -k k8s-addons/metallb/
