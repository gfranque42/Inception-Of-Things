apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
apt-get autoremove -y

rm /usr/local/bin/argocd

rm $(which k3d)
rm -rf ~/.config/k3d

rm -rf /usr/local/bin/kubectl
rm -rf ~/.kube
