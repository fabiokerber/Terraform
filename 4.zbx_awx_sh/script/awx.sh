#!/bin/bash
sudo yum update -y
sudo yum install -y git
sudo firewall-cmd --zone=public --add-port=6443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8472/udp --permanent
sudo firewall-cmd --zone=public --add-port=10250/tcp --permanent
sudo firewall-cmd --zone=public --add-port=2379-2380/tcp --permanent
sudo firewall-cmd --reload
sudo sed -i s/^SELINUX=.*$/SELINUX=permissive/ /etc/selinux/config && sudo setenforce 0
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
sudo systemctl enable k3s
mkdir /tmp/awx-operator
git clone https://github.com/ansible/awx-operator.git /tmp/awx-operator
export NAMESPACE=default
cd /tmp/awx-operator/ && git checkout 0.18.0 && make deploy
curl -o /tmp/awx.yml https://github.com/fabiokerber/Terraform/blob/main/4.zbx_awx_sh/files/awx.yml
