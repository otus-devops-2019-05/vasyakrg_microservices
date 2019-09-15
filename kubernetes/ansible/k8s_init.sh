#!/bin/bash

echo "RUN delpoy k8s"
echo "========================="

# echo ""
# echo "Create network"
# gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom
#
# echo ""
# echo "========================="
# echo "create network subnets"
# gcloud compute networks subnets create kubernetes \
#   --network kubernetes-the-hard-way \
#   --range 10.240.0.0/24
#
# echo ""
# echo "========================="
# echo "create local iptables"
# gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
#   --allow tcp,udp,icmp \
#   --network kubernetes-the-hard-way \
#   --source-ranges 10.240.0.0/24,10.200.0.0/16
#
# echo ""
# echo "========================="
# echo "create ingress iptables"
# gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
#   --allow tcp:22,tcp:6443,icmp \
#   --network kubernetes-the-hard-way \
#   --source-ranges 0.0.0.0/0
#
# echo ""
# echo "========================="
# echo "print firewall rules"
# gcloud compute firewall-rules list --filter="network:kubernetes-the-hard-way"
#
# echo "create static address"
# gcloud compute addresses create kubernetes-the-hard-way \
#   --region $(gcloud config get-value compute/region)
#
# echo "print ip address"
# gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"

# echo ""
# echo "========================="
# echo "Create three compute instances for controllers"
# for i in 0 1 2; do
#   gcloud compute instances create controller-${i} \
#     --async \
#     --boot-disk-size 200GB \
#     --can-ip-forward \
#     --image-family ubuntu-1804-lts \
#     --image-project ubuntu-os-cloud \
#     --machine-type n1-standard-1 \
#     --private-network-ip 10.240.0.1${i} \
#     --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
#     --subnet kubernetes \
#     --tags kubernetes-the-hard-way,controller
# done
#
# echo ""
# echo "========================="
# echo "Create one compute instance for worker"
# for i in 0; do
#   gcloud compute instances create worker-${i} \
#     --async \
#     --boot-disk-size 200GB \
#     --can-ip-forward \
#     --image-family ubuntu-1804-lts \
#     --image-project ubuntu-os-cloud \
#     --machine-type n1-standard-1 \
#     --metadata pod-cidr=10.200.${i}.0/24 \
#     --private-network-ip 10.240.0.2${i} \
#     --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
#     --subnet kubernetes \
#     --tags kubernetes-the-hard-way,worker
# done

echo ""
echo "========================="
echo "Print list the compute instances"
gcloud compute instances list

echo ""
echo "sleep for waiting to deploy OS of instance"
sleep 30
echo ""
echo "========================="
echo "Create ssl certificates"
scripts/2_k8s_create_ssl.sh
scripts/3_k8s_create_auth.sh
scripts/4_k8s_generate_data.sh

echo ""
echo "========================="
echo "create inventory"
scripts/5_k8s_create_inventory.sh

read -p "Press enter to continue"

echo ""
echo "========================="
echo "Executing delpoy workers"
ansible-playbook k8s_deploy_workers.yml
echo "complete"

echo ""
echo "========================="
echo "Executing delpoy controllers"
ansible-playbook k8s_deploy_controllers.yml
echo "complete"

echo ""
echo "========================="
echo "Create LB"
scripts/6_k8s_create_lb.sh
read -p "Press enter to continue"

echo ""
echo "========================="
echo "Create subnetworks rules"
scripts/7_k8s_remote_access.sh
scripts/8_k8s_network_routes.sh
read -p "Press enter to continue"


echo "Deploying the DNS Cluster Add-on"
kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns.yaml

echo "==========================="
echo "Deploy k8s-cluster complete"
