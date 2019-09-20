# Выполнено ДЗ № 9
 - [X] Основное ДЗ
 - [X] Задание со *
 - [X] Задание со **

## В процессе сделано:
- Ingress Controller
- Ingress
- Secret
- TLS
- LoadBalancer Service
- Network Policies
- PersistentVolumes
- PersistentVolumeClaims

### Задание со *
- Обновить mongo-network-policy.yml так, чтобы post-сервис дошел до базы данных.
```
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: reddit
              component: comment
        - podSelector:
            matchLabels:
              app: reddit
              component: post
```

### Задание со **
Описать создаваемый объект Secret в виде Kubernetes манифеста.

```
apiVersion: v1
kind: Secret
metadata:
  name: ui-ingress
  namespace: dev
type: Opaque
data:
  server.crt: LS0tLS1CRUdJTiBDR...
  server.key: LS0tLS1CRUdJTiBQU...
```
с помощью оборота cat tls.key | base64 и cat tls.crt | base64 - получил нужный мне шифр


## PR checklist
  - [X] Выставил label kebernetes
  - [X] Выставил label kebernetes-3
