#!/bin/bash

echo "Retrieve the kubernetes-the-hard-way static IP address"
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

echo "Generate a kubeconfig file for each worker node"
for instance in worker-0; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ssl/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=ssl/${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=ssl/${instance}.pem \
    --client-key=ssl/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=ssl/${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=ssl/${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=ssl/${instance}.kubeconfig
done

echo "Generate a kubeconfig file for the kube-proxy service"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ssl/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=ssl/kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=ssl/kube-proxy.pem \
    --client-key=ssl/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=ssl/kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=ssl/kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=ssl/kube-proxy.kubeconfig
}

echo "Generate a kubeconfig file for the kube-controller-manager service"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ssl/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=ssl/kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=ssl/kube-controller-manager.pem \
    --client-key=ssl/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=ssl/kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=ssl/kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=ssl/kube-controller-manager.kubeconfig
}

echo "Generate a kubeconfig file for the kube-scheduler service"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ssl/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=ssl/kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=ssl/kube-scheduler.pem \
    --client-key=ssl/kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=ssl/kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=ssl/kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=ssl/kube-scheduler.kubeconfig
}

echo "Generate a kubeconfig file for the admin user"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ssl/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=ssl/admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=ssl/admin.pem \
    --client-key=ssl/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=ssl/admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=ssl/admin.kubeconfig

  kubectl config use-context default --kubeconfig=ssl/admin.kubeconfig
}

echo "Copy the appropriate kubelet and kube-proxy kubeconfig files to worker instance"
for instance in worker-0; do
  gcloud compute scp ssl/${instance}.kubeconfig ssl/kube-proxy.kubeconfig ${instance}:~/
done

echo "Copy the appropriate kube-controller-manager and kube-scheduler kubeconfig files to each controller instance"
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp ssl/admin.kubeconfig ssl/kube-controller-manager.kubeconfig ssl/kube-scheduler.kubeconfig ${instance}:~/
done
