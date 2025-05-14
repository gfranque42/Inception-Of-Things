
# sudo usermod -aG docker $USER
# newgrp docker

# k3d setup
k3d cluster create my-cluster --api-port 6443 --port 8080:80@loadbalancer --port 8443:443@loadbalancer --agents 2
kubectl config use-context k3d-my-cluster

# k3d argocd setup
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl config set-context --current --namespace=argocd
kubectl wait --for=condition=Ready -A
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl port-forward svc/argocd-server -n argocd 8083:443 &

# argocd CLI setup
argocd cluster add -y k3d-my-cluster
kubectl config set-context --current --namespace=argocd
argocd app create playground --repo https://github.com/gfranque42/Inception-Of-Things.git --path p3/app --dest-server https://kubernetes.default.svc --dest-namespace dev --server localhost:8083 --insecure

# argocd account update-password
argocd app sync playground
argocd app get playground
