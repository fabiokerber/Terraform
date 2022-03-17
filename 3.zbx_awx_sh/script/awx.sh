#!/bin/bash
sudo timedatectl set-timezone America/Sao_Paulo
sudo apt-get update
sudo apt-get install -y python3-pip
sudo apt-get install -y build-essential libssl-dev libffi-dev python3-dev python3-testresources python3-docker unzip pwgen
sudo pip3 install --upgrade pip && sudo pip3 install --upgrade setuptools
sudo pip3 install setuptools_rust wheel && sudo pip3 install ansible && sudo pip3 install docker-compose
sudo pip3 install requests==2.22.0
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt install -y ansible
sudo apt install -y nodejs npm
sudo npm install npm --global
sudo pip3 install docker-compose==1.29.2
sudo wget -O /tmp/17.1.0.zip https://github.com/ansible/awx/archive/17.1.0.zip
sudo unzip /tmp/17.1.0.zip -d /tmp
sudo rm -f /tmp/awx-17.1.0/installer/inventory
curl -o /tmp/awx-17.1.0/installer/inventory https://raw.githubusercontent.com/fabiokerber/lab/main/zbx_awx_sh/files/inventory
sudo sed -i "s|admin_password=password|admin_password=`(pwgen -N 1)`|g" /tmp/awx-17.1.0/installer/inventory
sudo sed -i "s|secret_key=awxsecret|secret_key=`(pwgen -N 1 -s 30)`|g" /tmp/awx-17.1.0/installer/inventory
sudo mkdir -p /var/lib/awx
sudo ansible-playbook -i /tmp/awx-17.1.0/installer/inventory /tmp/awx-17.1.0/installer/install.yml
sudo pip3 install ansible-tower-cli
sudo apt-get install -y libjson-pp-perl jq