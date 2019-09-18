# Выполнено ДЗ № 8
 - [X] Основное ДЗ
 - [X] Задание со *

## В процессе сделано:
- Развернул локальное окружение для работы с Kubernetes
- Развернул Kubernetes в GKE
- Запустил reddit в Kubernetes

### Задание со *
- Развернул Kubenetes-кластер в GKE с помощью Terraform
- Создал YAML-манифесты для описания созданных сущностей для включения dashboard

### От себя
  - у меня на Маке, при установке и развертке minikube, дашбоард плагин был выключен
    - включил через 'minikube addons enable dashboard', потом прописал ему service c NodePort в файлики ./kubernetes/kube-system/dashboard-service.yml
    - далее, была проблема с линком для входа, предлагался уже зарезанный линк http://localhost:8001/ui, обошел через http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/about?namespace=default
    - далее возникла проблема с токеном. не стал создавать RBAC сущности, тупо захардкодил через
    ```
    kubectl edit deployment/kubernetes-dashboard --namespace=kube-system.

      containers:
      - args:
        - --auto-generate-certificates
        - --enable-skip-login            # <-- add this line
    ```

## PR checklist
  - [X] Выставил label kebernetes
  - [X] Выставил label kebernetes-2
