#!/bin/bash

echo "Generate CA, cert + key"
{

cat > ssl/ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ssl/ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert -initca ssl/ca-csr.json | cfssljson -bare ssl/ca

}

echo "Generate admin cert"
{

cat > ssl/admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=./ssl/ca-config.json \
  -profile=kubernetes \
  ssl/admin-csr.json | cfssljson -bare ssl/admin

}

echo "generate cert for Worker-node"
for instance in worker-0; do
cat > ssl/${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

EXTERNAL_IP=$(gcloud compute instances describe ${instance} \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

INTERNAL_IP=$(gcloud compute instances describe ${instance} \
  --format 'value(networkInterfaces[0].networkIP)')

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ssl/${instance}-csr.json | cfssljson -bare ssl/${instance}
done

echo "Generate the kube-controller-manager client certificate and private key"
{

cat > ssl/kube-controller-manager-csr.json <<EOF
{
  "CN": "system:kube-controller-manager",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-controller-manager",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -profile=kubernetes \
  ssl/kube-controller-manager-csr.json | cfssljson -bare ssl/kube-controller-manager

}

echo "Generate the kube-proxy client certificate and private key"
{
cat > ssl/kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:node-proxier",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -profile=kubernetes \
  ssl/kube-proxy-csr.json | cfssljson -bare ssl/kube-proxy
}

echo "Generate the kube-scheduler client certificate and private key"
{

cat > ssl/kube-scheduler-csr.json <<EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-scheduler",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -profile=kubernetes \
  ssl/kube-scheduler-csr.json | cfssljson -bare ssl/kube-scheduler
}

echo "Generate the Kubernetes API Server certificate and private key"
{

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

cat > ssl/kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,kubernetes.default \
  -profile=kubernetes \
  ssl/kubernetes-csr.json | cfssljson -bare ssl/kubernetes

}

echo "Generate the service-account certificate and private key"
{

cat > ssl/service-account-csr.json <<EOF
{
  "CN": "service-accounts",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ssl/ca.pem \
  -ca-key=ssl/ca-key.pem \
  -config=ssl/ca-config.json \
  -profile=kubernetes \
  ssl/service-account-csr.json | cfssljson -bare ssl/service-account

}

echo "Copy the appropriate certificates and private keys to each worker instance"
for instance in worker-0; do
  gcloud compute scp ssl/ca.pem ssl/${instance}-key.pem ssl/${instance}.pem ${instance}:~/
done

echo "Copy the appropriate certificates and private keys to each controller instance"
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp ssl/ca.pem ssl/ca-key.pem ssl/kubernetes-key.pem ssl/kubernetes.pem \
    ssl/service-account-key.pem ssl/service-account.pem ${instance}:~/
done
