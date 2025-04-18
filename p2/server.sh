apt update
# apt upgrade -y
apt install -y curl

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--token 12354 --write-kubeconfig-mode 0644 --node-ip 192.168.56.110" sh -s -

sudo sh -c 'echo "192.168.56.110 site1.local" >> /etc/hosts'
sudo sh -c 'echo "192.168.56.110 site2.local" >> /etc/hosts'
sudo sh -c 'echo "192.168.56.110 site3.local" >> /etc/hosts'



