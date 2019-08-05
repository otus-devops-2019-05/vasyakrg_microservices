# vasyakrg_microservices
[![Build Status](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/vasyakrg_microservices)

## HW2
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
