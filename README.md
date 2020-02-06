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
Для создания образа в директории packer, в которой находится centos.json выполняю следующую команду:
```console
packer build centos.json
```
В результате данной команды должен появиться файл centos-7.7.1908-kernel-5-x86_64-Minimal.box  
#### Проверка образа
Импортирую образ в vagrant
```console
vagrant box add --name centos-7-5 centos-7.7.1908-kernel-5-x86_64-Minimal.box
```
Вывод команды vargarnt box list выглядит следующим образом:
```console
vagrant box list
centos-7-5            (virtualbox, 0)
```
Создаю Vagrantfile
```console
vagrant init centos-7-5
```
Запускаю машину и подключаюсь к ней по ssh
```console
vagrant up
....
vagrant ssh
```
Проверяю новое ли у машины ядро. Вывод:
```console
[vagrant@kernel-update ~]$ uname -r
5.5
```
#### Загружаю образ vagrant на Vagrant cloud
Выполняю в CLI следующие команды
```console
vagrant cloud auth login
Vagrant Cloud username or email: <user_email>
Password (will be hidden): 
Token description (Defaults to "Vagrant login from DS-WS"):
You are now logged in.
```
Публикую бокс
Выполняю в CLI следующие команды
```console
vagrant cloud publish --release <username>/centos-7-5 1.0 virtualbox \
        centos-7.7.1908-kernel-5-x86_64-Minimal.box
```
#### Добавление изменений в git
В CLI выполняю следующие команды:
```console
git add packer/stage-1-kernel-update.sh packer/Vagrantfile
git commit -m 'homework1'
git push
```
