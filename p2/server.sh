apt update
# apt upgrade -y
apt install -y curl

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--token 12354 --write-kubeconfig-mode 0644 --node-ip 192.168.56.110" sh -s -


echo "192.168.56.110 app1.com" >> /etc/hosts
echo "192.168.56.110 app2.com" >> /etc/hosts
echo "192.168.56.110 app3.com" >> /etc/hosts

sleep 15 

kubectl apply -f website-c.yaml
kubectl apply -f website-b.yaml
kubectl apply -f website-a.yaml

kubectl wait --for=condition=Ready pod -l app=website-a --timeout=60s || true
kubectl wait --for=condition=Ready pod -l app=website-b --timeout=60s || true
kubectl wait --for=condition=Ready pod -l app=website-c --timeout=60s || true

kubectl apply -f ingress.yaml



