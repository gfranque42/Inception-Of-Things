#!/bin/bash

#basic setup
sudo apt update
sudo apt install -y curl ca-certificates

#kubectl setup
curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#docker setup
# Add Docker's official GPG key:
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker

#k3d setup
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo k3d cluster create my-cluster --api-port 6443 --port 8080:80@loadbalancer --port 8443:443@loadbalancer --agents 2
sudo kubectl config use-context k3d-my-cluster

#argocd setup
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl config set-context --current --namespace=argocd
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
sudo kubectl port-forward svc/argocd-server -n argocd 8083:443

#argocd cli setup
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

sudo argocd cluster add -y k3d-my-cluster
sudo kubectl config set-context --current --namespace=argocd
sudo argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

sudo argocd account update-password
sudo argocd app get guestbook
sudo argocd app sync guestbook
