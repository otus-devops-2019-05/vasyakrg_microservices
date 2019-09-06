# Выполнено ДЗ № 6
 - [X] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
  - Сбор неструктурированных логов
  - Визуализация логов
  - Сбор структурированных логов
  - Распределенная трасировка

### Задание со *
  - парсинг разобрал по элементам:
```
<grok>
  pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{URIPATH:path} \| request_id=%{GREEDYDATA:request_id} \| remote_addr=%{IPV4:remote_addr} \| method=%{GREEDYDATA:method} \| response_status=%{INT:response_status}
</grok>
```

### От себя
  - прикол с elasticsearch по **max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]** обошел через
    > sudo sysctl -w vm.max_map_count=262144

  - так же пришлось поиграть с переменными в контейнере, elasticsearch вообще очень требовательный:
```
environment:
  - node.name=elasticsearch
  - cluster.initial_master_nodes=elasticsearch
  - cluster.name=docker-cluster
  - bootstrap.memory_lock=true
ulimits:
  memlock:
    soft: -1
    hard: -1
```

### Задание со **
  1. в Dockerfile приложение убрали ENV - контейнеры не могли друг друга найти. Прописал в docker-compose.yml напрямую

## PR checklist
  - [X] Выставил label logging
  - [X] Выставил label logging-1
