#!/bin/bash
KUBECONFIG=ansible/buffer/admin.conf

kubectl --kubeconfig=$KUBECONFIG create namespace ingress-nginx
kubectl --kubeconfig=$KUBECONFIG apply -k k8s-addons/nginx-ingress/bare-metal/
