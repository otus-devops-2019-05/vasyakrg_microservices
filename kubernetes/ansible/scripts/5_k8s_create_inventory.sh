#!/bin/bash

cat > inventory <<EOF
all:
  hosts:
    controller-[0:2]:
    worker-0:
  children:
    controllers:
      hosts:
        controller-0:
          ansible_host: `echo $(gcloud compute instances describe controller-0 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          int_ip: 10.240.0.10
          ext_ip: `echo $(gcloud compute instances describe controller-0 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          ansible_python_interpreter: "/usr/bin/python3"
        controller-1:
          ansible_host: `echo $(gcloud compute instances describe controller-1 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          int_ip: 10.240.0.11
          ext_ip: `echo $(gcloud compute instances describe controller-1 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          ansible_python_interpreter: "/usr/bin/python3"
        controller-2:
          ansible_host: `echo $(gcloud compute instances describe controller-2 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          int_ip: 10.240.0.12
          ext_ip: `echo $(gcloud compute instances describe controller-2 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          ansible_python_interpreter: "/usr/bin/python3"
    workers:
      hosts:
        worker-0:
          ansible_host: `echo $(gcloud compute instances describe worker-0 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          int_ip: 10.240.0.20
          ext_ip: `echo $(gcloud compute instances describe worker-0 --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')`
          ansible_python_interpreter: "/usr/bin/python3"
          pod_cidr: "10.200.0.0/24"
EOF
echo "Inventory created"
