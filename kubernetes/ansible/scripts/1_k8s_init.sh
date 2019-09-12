#!/bin/bash

echo "Create network"
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

echo "create network subnets"
gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24

echo "create local iptables"
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

echo "create ingress iptables"
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

echo "print firewall rules"
gcloud compute firewall-rules list --filter="network:kubernetes-the-hard-way"

# echo "create static address"
# gcloud compute addresses create kubernetes-the-hard-way \
#   --region $(gcloud config get-value compute/region)

echo "print ip address"
gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"

echo "Create three compute instances"
for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done

echo "Create one compute instance"
for i in 0; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done

echo "Print list the compute instances"
gcloud compute instances list

echo "Connect to controller-0"
gcloud compute ssh controller-0
