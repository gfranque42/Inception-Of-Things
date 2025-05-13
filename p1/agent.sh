apt update
# apt upgrade -y
apt install -y curl
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token 12354 --node-ip 192.168.56.111" sh -s -