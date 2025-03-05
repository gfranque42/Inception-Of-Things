sudo apt update
sudo apt upgrade -y
sudo apt install -y curl
# curl -sfL https://get.k3s.io | K3S_URL=https://k3s.example.com agent --token 12345 -- bind-address 192.168.56.111 sh -s -
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token 12345" sh -s -