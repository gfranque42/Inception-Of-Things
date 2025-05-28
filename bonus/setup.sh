# k3d setup
k3d cluster create my-cluster --api-port 6443 --agents 2
kubectl config use-context k3d-my-cluster

# k3d argocd setup
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f ./install.yaml
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=600s
kubectl get all
kubectl port-forward svc/argocd-server -n argocd 8082:443 &
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# argocd CLI setup
ARGOCD_PASSWORD=$(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 --decode)
echo "Argocd Password: $ARGOCD_PASSWORD"
argocd login localhost:8082 --username admin --password "$ARGOCD_PASSWORD" --insecure
argocd cluster add -y k3d-my-cluster --server localhost:8082 --insecure
argocd app create gfranque-playground --repo http://host.k3d.internal:8080/root/gfranque.git --path playground/ --dest-server https://kubernetes.default.svc --dest-namespace dev --server localhost:8082 --insecure --upsert

# argocd account update-password
argocd app sync gfranque-playground
argocd app get gfranque-playground
argocd app set gfranque-playground --sync-policy automated
kubectl port-forward svc/playground-service 8888:80 -n dev &
