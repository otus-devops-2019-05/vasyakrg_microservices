#!/bin/bash

echo "Delete the controller and worker compute instances"
gcloud -q compute instances delete \
  controller-0 controller-1 controller-2 \
  worker-0

echo "Delete the external load balancer network resources"
{
  gcloud -q compute forwarding-rules delete kubernetes-forwarding-rule \
    --region $(gcloud config get-value compute/region)

  gcloud -q compute target-pools delete kubernetes-target-pool

  gcloud -q compute http-health-checks delete kubernetes

  gcloud -q compute addresses delete kubernetes-the-hard-way
}

echo "Delete the kubernetes-the-hard-way firewall rules"
gcloud -q compute firewall-rules delete \
  kubernetes-the-hard-way-allow-nginx-service \
  kubernetes-the-hard-way-allow-internal \
  kubernetes-the-hard-way-allow-external \
  kubernetes-the-hard-way-allow-health-check

echo "Delete the kubernetes-the-hard-way network VPC"
{
  gcloud -q compute routes delete \
    kubernetes-route-10-200-0-0-24

  gcloud -q compute networks subnets delete kubernetes

  gcloud -q compute networks delete kubernetes-the-hard-way
}
