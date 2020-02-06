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

