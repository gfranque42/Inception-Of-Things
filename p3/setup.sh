
# sudo usermod -aG docker $USER
# newgrp docker

# k3d setup
k3d cluster create my-cluster --api-port 6443 --agents 2
kubectl config use-context k3d-my-cluster

# k3d argocd setup
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f ./install.yaml
kubectl config set-context --current --namespace=argocd
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=600s
kubectl get all 
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# argocd CLI setup
ARGOCD_PASSWORD=$(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 --decode)
echo $ARGOCD_PASSWORD
argocd login localhost:8080 --username admin --password "$ARGOCD_PASSWORD" --insecure
argocd cluster add -y k3d-my-cluster --server localhost:8080 --insecure
kubectl config set-context --current --namespace=argocd
argocd app create playground --repo https://github.com/gfranque42/gfranque.git --path playground/ --dest-server https://kubernetes.default.svc --dest-namespace dev --server localhost:8080 --insecure


# # argocd account update-password
argocd app sync playground
argocd app get playground
argocd app set playground --sync-policy automated
