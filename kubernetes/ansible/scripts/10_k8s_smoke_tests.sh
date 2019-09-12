#!/bin/bash

echo "Create a generic secret"
kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"

gcloud compute ssh controller-0 \
--command "sudo ETCDCTL_API=3 etcdctl get \
--endpoints=https://127.0.0.1:2379 \
--cacert=/etc/etcd/ca.pem \
--cert=/etc/etcd/kubernetes.pem \
--key=/etc/etcd/kubernetes-key.pem\
/registry/secrets/default/kubernetes-the-hard-way | hexdump -C"


echo "Create a deployment for the nginx web server"
kubectl run nginx --image=nginx
sleep 10
kubectl get pods -l run=nginx


echo "Forward port 8080 on your local machine to port 80 of the nginx pod"
POD_NAME=$(kubectl get pods -l run=nginx -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:80
