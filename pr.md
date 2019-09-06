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
  2. обнаружил задержку при просмотре любового поста
    | Date        | Time	    | Relative Time |	Annotation	  | Address                 |
    |:-----------:|:---------:|:-------------:|:-------------:|:-----------------------:|
    | 06.09.2019  | 11:47:39	| 2.088ms	      | Client Start	| 10.10.2.5:9292 (ui_app) |
    | 06.09.2019  | 11:47:39	| 4.258ms	      | Server Start	| 10.10.1.7:5000 (post)   |
    | 06.09.2019  | 11:47:42	| 3.014s	      | Server Finish	| 10.10.1.7:5000 (post)   |
    | 06.09.2019  | 11:47:42	| 3.020s	      | Client Finish	| 10.10.2.5:9292 (ui_app) |
    > в коде умышленно стояла задержка time.sleep(3), исправил

## PR checklist
  - [X] Выставил label logging
  - [X] Выставил label logging-1
