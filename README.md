# vasyakrg_microservices
[![Build Status](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices)

## HW1
  - установил docker на локальную машину
  - создал образ и зарегился в docker-github
  - поиграл с docker inspect (разницу между container и image - прописал в docker-monolith/docker-1.log)
  - подключился через docker-machine в GCP, поднял там инстанс с доккером
  - как итог - созбрал образ с контейнера в GCP и запушил его в docker-github
  
### Задание со *
  - через пакер поднимаю имедж, ансиблом ставлю туда докер и разворачиваю с docker-hub ранее созданный образ
  - через терру создаю несколько инстансов на основе ранее созданного пакером имеджа
    - прописываю ssh-ключи для доступа
    - создаю в своей днс-зоне читаемые имена

## Автор
   * **Vassiliy Yegorov** - *Initial work* - [vasyakrg](https://github.com/otus-devops-2019-05//vasyakrg_microservices)
