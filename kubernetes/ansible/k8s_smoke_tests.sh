#!/bin/bash

echo "Get component status:"
kubectl get componentstatuses
echo "Get nodes:"
kubectl get nodes

echo "Install test busybox app"
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
kubectl get pods -l run=busybox
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

echo "Check nslookup from apps"
kubectl exec -ti $POD_NAME -- nslookup kubernetes
