# Выполнено ДЗ № 11
 - [X] Основное ДЗ
 - [X] Задание со *
 - [X] Задание со **
 - [X] Задание со ***

## В процессе сделано:
- включил сбор метрик с node-exporter и kubeStateMetrics
- прописал отдельные джобы для группировки по приложениям post, comment, ui
- добавил собственные дашборды в графану и параметризировал (/monitoring/grafana/dashboards/UI_Service_monitoring_k8s.json)
- поднял EFK и поигрался с отчетами логирования


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

### Задание со ***
- переписал поднятие EFK на Helm Charts - взял за основу написанные чарты (велосипед - не наше все), перебил переменные в custom_* исходя из легаси-файлов в задании

### От себя
- вот тебе и чарты, с прометеем-оператором намучился, пока отлаживал их поделку, приходилось все руками постоянно подчищать
```
Error: object is being deleted: customresourcedefinitions.apiextensions.k8s.io
```
- ну и как же я люблю эти "облака" )) на моменте поднятия EFK, гугль решил апнуть версию k8s на моем кластере, а я и не сразу понял, что происходит
  - если бы винда стояла на компе - пошел бы и ее переустанавливать, пока не разобрался, что там обычный maintenance идет

## PR checklist
  - [X] Выставил label kebernetes
  - [X] Выставил label kebernetes-5
