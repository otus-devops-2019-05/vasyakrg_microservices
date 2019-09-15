#!/bin/bash

echo "Generate an encryption key"
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

echo "Create the encryption-config.yaml encryption config file"
cat > ssl/encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

echo "Copy the encryption-config.yaml encryption config file to each controller instance"
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp ssl/encryption-config.yaml ${instance}:~/
done
