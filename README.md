# eugenebbr_infra
eugenebbr Infra repository

***Задания с SSH***

Для подключения к серверу внутренней сети в одну команду из локального рабочего места, используя внешний сервер bastion-host, необходимо использовать следующий метод:

```
ssh -i <путь к ключу> -t -A <пользователь>@<внешний IP сервера bastion-host> ssh <IP конечного сервера внутренней сети>
```

Например:

```
ssh -i ~/.ssh/appuser -t -A appuser@34.76.5.251 ssh 10.132.0.5
```

Предварительно нужно добавить приватный ключ в ssh агент авторизации командой:

```
ssh-add <путь к ключу>
```

Для подключения к серверу внутренней сети по алиасу из локального рабочего места, сначала нужно создать алиас:

```
alias <имя алиаса>="<команда>"
```

Например:

```
alias someinternalhost="ssh -i ~/.ssh/appuser -t -A appuser@34.76.5.251 ssh 10.132.0.5"
```

Подключение осуществляется посредством ввода имени алиаса:

```
someinternalhost
```

***Задания с VPN***

Конфигурация ВМ следующая:

```
bastion_IP = 34.76.5.251
someinternalhost_IP = 10.132.0.5
```

Выполненные шаги:

- Развернут VPN сервер и БД, с использованием скрипта setupvpn.sh
- Создан VPN пользователь test
- Добавлен сертификат Let's Encrypt
- Веб-интерфейс доступен по адресу https://34.76.5.251.xip.io/


***Домашнее задание №6***

Для деплоя тестового приложения было создано три скрипта:

1. Установка ruby, скрипт install_ruby.sh
2. Установка MongoDB, скрипт install_mongodb.sh
3. Установка и запуск приложения, скрипт deploy.sh

Для выполнения дополнительного задания был создан скрипт startup_script.sh, который разворачивает приложение при создании инстанса.
Скрипт был добавлен в бакет, для публичного доступа к нему из интернет по URL.
Содержание скрипта startup_script.sh следующее:

```
gcloud compute instances create reddit-app --scopes storage-ro --metadata startup-script-url=https://storage.googleapis.com/eugbbr-bucket/startup_script.sh --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure
```

Для выполнения дополнительного задания по изменению правила firewall из консоли была использована следующая команда:

```
gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --direction=INGRESS --target-tags=puma-server
```

Для проверки инстанса используется следующая конфигурация:

```
testapp_IP = 35.241.159.54
testapp_port = 9292
```
