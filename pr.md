# Выполнено ДЗ № 11
 - [X] Основное ДЗ
 - [X] Задание со *
 - [X] Задание со **

## В процессе сделано:
- включил сбор метрик с node-exporter и kubeStateMetrics
- прописал отдельные джобы для группировки по приложениям post, comment, ui
- добавил собственные дашборды в графану и параметризировал (/monitoring/grafana/dashboards/UI_Service_monitoring_k8s.json)


### Задание со *
- настроил слежение со стороны прометея и посыл через алетрменеджер сообщений себе в слак
  - собственно, по старым наработкам

### Задание со **
- поднял prometheus-operator и настроил слежение на приложением POST
```
prometheus:
  additionalServiceMonitors:
  - name: post-component
    selector:
      matchLabels:
        component: post
    namespaceSelector:
      any: true
    endpoints:
      - targetPort: 5000
        interval: 30s
        path: /metrics
        scheme: http
```

### От себя
- вот тебе и чарты, с оператором намучился, пока отлаживал их поделку, приходилось все руками постоянно подчищать
```
Error: object is being deleted: customresourcedefinitions.apiextensions.k8s.io
```

## PR checklist
  - [X] Выставил label kebernetes
  - [X] Выставил label kebernetes-4
