# Выполнено ДЗ № 7
 - [X] Основное ДЗ
 - [X] Задание со *

## В процессе сделано:
- Разобрал на практике все компоненты Kubernetes, развернул их вручную используя The Hard Way work от express-42;
- Ознакомился с описанием основных примитивов нашего приложения и его дальнейшим запуском в Kubernetes.

### Задание со *
- Описал установку компонентов Kubernetes из THW в виде скприптов и Ansible-плейбуков в папке kubernetes/ansible;
- запускать
  > k8s_init.sh

- убить все на фиг
  > k8s_destroy.sh

### От себя
  - не победил, почему нет проброса dns от coredns в голову. видимо где-то в фаерах нет нужного правила.
```
nslookup kubernetes
Server:    10.32.0.10
Address 1: 10.32.0.10

nslookup: can't resolve 'kubernetes'
command terminated with exit code 1
```
а вот если
```
nslookup kubernetes 10.200.0.6
Server:    10.200.0.6
Address 1: 10.200.0.6 10-200-0-6.kube-dns.kube-system.svc.cluster.local

Name:      kubernetes
Address 1: 10.32.0.1 kubernetes.default.svc.cluster.local
```

## PR checklist
  - [X] Выставил label kebernetes
  - [X] Выставил label kebernetes-1
