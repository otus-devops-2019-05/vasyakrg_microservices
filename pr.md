# Выполнено ДЗ № 5
 - [X] Основное ДЗ
 - [X] Задание со *
 - [X] Задание со **
 - [] Задание со ***

## В процессе сделано:
  - собрал мониторинг Docker контейнеров несколькими доступными средствами
  - настроил визуализацию через Графану
  - подключил сборщики метрик приложений
  - подключил алертинг в слак и на почту

### Задание со *
- расширил Makefile
- активировал экспериментальные (читать-скучные) метрики самого докера, повесил джобу в прометей, нарисовал (спер готовый) даш для графаны, положил в grafana/dashboards/Docker-metrics.json
- поднял Telegraf-метрики, повесил джобу в прометей, нарисовал (спер готовый) даш для графаны, положил в grafana/dashboards/Telegraf-Docker.json
- прописал email настройки в Alertmanager, повесил так же на severity: critical

### Задание со **
  - Реализовал автоматическое добавление источника данных и созданных в данном ДЗ дашбордов в графану
  - к docker-host подключил StackDriver, вытащил кучу метрик по CPU, MEM, Disk и прочему
    > curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh && sudo bash install-monitoring-agent.sh
    > curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh && sudo bash install-logging-agent.sh

### Задание со ***
  - подключил прокси для прометея - Trickster и повесил его на 9089 порт, Графану переключил на импорт метрик через него, в Графане добавил дашборд активности

### От себя
  -

## PR checklist
  - [X] Выставил label monitoring
  - [X] Выставил label monitoring-2
