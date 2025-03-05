sudo apt update
sudo apt upgrade -y
sudo apt install -y curl
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-backend vxlan --token 12345 --bind-address 192.168.56.110" sh -s -

