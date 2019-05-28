#!/bin/bash
KUBECONFIG=ansible/buffer/admin.conf

kubectl --kubeconfig=$KUBECONFIG apply -k k8s-addons/k8s-dashboard/

echo -e "\nWait 30s to complete the initialization"
sleep 30

echo -e "\nConfigure access to the dashboard"

kubectl --kubeconfig=$KUBECONFIG create serviceaccount cluster-admin-dashboard-sa
kubectl --kubeconfig=$KUBECONFIG create clusterrolebinding cluster-admin-dashboard-sa --clusterrole=cluster-admin --serviceaccount=default:cluster-admin-dashboard-sa

echo -e "\nRead the generated token and IP"

TOKEN=$(kubectl describe secret $(kubectl -n kube-system get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') | awk '$1=="token:"{print $2}')

IP=$(kubectl get svc --kubeconfig=$KUBECONFIG --all-namespaces | grep kubernetes-dashboard | awk '{print $5}')

echo -e "\nLogin to the kubernetes dashboard using \n\n\"https://$IP\"\n\nThe token is:\n$TOKEN"
