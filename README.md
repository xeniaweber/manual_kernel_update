## Установка необходимых инструментов 
Для выполнения домашнего задания были установлены следующие инструменты:
#### Vagrant
```console
curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb && \
sudo dpkg -i vagrant_2.2.6_x86_64.deb
```
#### VirtualBox
```console
apt install virtualbox
```
#### Packer
```console
curl https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip | \
sudo gzip -d > /usr/local/bin/packer && \
sudo chmod +x /usr/local/bin/packer
```
#### Git
```console
apt install git
```
## Созадние образа
 
Для копирования репозитория https://github.com/dmitry-lyutenko/manual_kernel_update в свой нажимаю Fork.
Для получения файлов из репозитория на свою локальную машину делаю
```console
git clone <ссылка на репозиторий> 
```
Ссылку можно получить при нажатии кнопки "clone or download"
Получив необходимые файлы, делаю следующие правки.
#### Изменение скрипта для сборки ядра 
В скрипте описан процесс сборки из репозитория. Согласно заданию, обновиться нужно из исходников.
Скрипт подтягивается в общем файле centos.json, с помощью которого будет собираться образ утилитой packer.
```console
 "scripts" :
            [
              "scripts/stage-1-kernel-update.sh",
              "scripts/stage-2-clean.sh"
 ```
 Скрипт, в котором описан процесс сборки - stage-1-kernel-update.sh
 Меняю его содержимое так, чтобы обновление происходило из исходнкиов. Скрипт теперь выглядит так:
 [stage-1-kernel-update.sh](https://github.com/xeniaweber/manual_kernel_update/blob/master/packer/scripts/stage-1-kernel-update.sh)
