# vasyakrg_microservices
[![Build Status](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices)

## HW5
  -

### Задание со *
 - расширил Makefile
  - теперь он умеет больше:
  ```
    > make [command]

    - help                           This help.
    - build                          Build docker images
    - build-comment                  Build comment image
    - build-post                     Build post image
    - build-ui                       Build ui image
    - build-alertmanager             Build alertmanager image
    - build-prometheus               Build prometheus image
    - build-blackbox                 Build blackbox-exporter image

    - release                        Make a release by building and publishing the `{version}` ans `latest` tagged containers to Docker Hub

    - push                           Publish the `{version}` ans `latest` tagged containers to Docker Hub
    - publish-latest                 Publish the `latest` taged container to Docker HubDocker Hub
    - publish-monitoring             Publish the 'latest' monitoring container to Docker HubDocker Hub
    - publish-version                Publish the `{version}` taged container to Docker Hub
    - tag                            Generate container tag

    - docker-login                   Login to Docker Hub
  ```
  - Прометей теперь собирает в том числе и экспериментальные метрики самого докера с '10.10.1.1:9323', а Графана рисует графики
  - Прометей через сервис Telegraf опрашивает docker-host (минимально), а Графана рисует графики
  - Alertmanager, теперь так же отправляет сообщения на почту, так же на severity: critical

### Задание со **
  -

### Задание со ***  


## HW4
 - поднял контейнер с прометеем, поигрался с графиками, паданием сервисов
 - поднял нод-экспортер, пробросил его в сеть с прометеем, положил CPU с докер-хоста :)
 - залил все имаджи на [hub.docker.com](https://hub.docker.com/u/vasyakrg)

### Задание со *
 - подключил мониторинг Mongodb

### Задание со **
  - подключил blackbox-exporter

### Задание со ***
  - прописал make с разной степенью функционала.
  - .docker-creds файл с паролем от докер-хаба должен желать в корне репы
  - в самом мейке переменная DOCKER_REPO - определяет логин от докер-хаба


## HW3
 - через терраформ создается и поднимается машина с установленным доккером и gitlab-ci в одном из докеров
 - с помощью скриптов в папке gitlab-ci можно поднять нужно кол-во ранеров на чистых машинах
 - приложение через пайплайн пакуется в докер и запускается на локальном ранере

## HW2
  - монолитное приложение разбито на 4 микросервиса:
    - и теперь запускается и собирается через композер
  - контейнерам можно задавать префикс в названии
  - а так же изменять переменные окружения
  - результат доступен по линку:
    > http://<docker-host-ip>:9292/

### Задание со *
  - переопределил docker-compose, подключив вольюмы и команды для запуска дебага

## HW1
  - монолитное приложение разбито на 4 микросервиса:
    - БД
    - сервис управления постами
    - сервис управления комментами
    - сервис UI с веб-мордой
  - данные базы хранятся во внешнем волюме и не зависят от состояния контейнеров
  - результат доступен по линку:
    > http://<docker-host-ip>:9292/

### Задание со *
  - запустил сервисы с другими сетевыми алиасами, используя переназначение ENV-переменных

### Задание со **
  - поиграл с размером имеджа, использовал ruby:2.3-alpine образ, тем самым ушел с 781 до 452, а потом и вовсе до 305мб

## Автор
   * **Vassiliy Yegorov** - *Initial work* - [vasyakrg](https://github.com/otus-devops-2019-05//vasyakrg_microservices)
