#!/bin/bash
sudo timedatectl set-timezone America/Sao_Paulo
sudo yum update -y
sudo yum install -y git make gcc perl-core pcre-devel wget zlib-devel
sudo systemctl stop firewalld && sudo systemctl disable firewalld
sudo sed -i s/^SELINUX=.*$/SELINUX=permissive/ /etc/selinux/config && sudo setenforce 0
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
mkdir ~/awx-operator
git clone https://github.com/ansible/awx-operator.git ~/awx-operator
export NAMESPACE=awx
cd ~/awx-operator/ && git checkout 0.18.0 && make deploy
mkdir ~/awx-on-k3s
git clone https://github.com/kurokobo/awx-on-k3s.git ~/awx-on-k3s
wget https://ftp.openssl.org/source/old/1.1.1/openssl-1.1.1j.tar.gz -O /tmp/openssl.tar.gz
tar xvf /tmp/openssl.tar.gz -C /tmp
cd /tmp/openssl-* && ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
sudo make
sudo make install
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64" >> ~/.bashrc
AWX_HOST="vmawxbrsh.brazilsouth.cloudapp.azure.com"
cd ~/awx-on-k3s && openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -out ./base/tls.crt -keyout ./base/tls.key -subj "/CN=${AWX_HOST}/O=${AWX_HOST}" -addext subjectAltName="DNS:${AWX_HOST}"
sed -i 's|hostname: awx.example.com|hostname: vmawxbrsh.brazilsouth.cloudapp.azure.com|g' ~/awx-on-k3s/base/awx.yaml
sed -i '23s/      - password=Ansible123!/      - password=123@mudar/' ~/awx-on-k3s/base/kustomization.yaml
sed -i '29s/      - password=Ansible123!/      - password=123@mudar/' ~/awx-on-k3s/base/kustomization.yaml
sudo mkdir -p /data/{postgres,projects}
sudo chmod 755 /data/postgres
sudo chown 1000:0 /data/projects
kubectl apply -k ~/awx-on-k3s/base