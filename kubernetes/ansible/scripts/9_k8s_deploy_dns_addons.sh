#!/bin/bash

echo "Deploy the coredns cluster add-on"
kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns.yaml

echo "List the pods created by the kube-dns deployment"
kubectl get pods -l k8s-app=kube-dns -n kube-system

echo "Create a busybox deployment:"
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
kubectl get pods -l run=busybox

echo "Retrieve the full name of the busybox pod"
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")
kubectl exec -ti $POD_NAME -- nslookup kubernetes
