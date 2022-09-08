kubectl create -f namespace.yml 
kubectl apply -f deployment.yaml
kubectl create -f loadbalancer.yaml
kubectl expose deployment dev-ui-deployment -n devui --port 80 --type=LoadBalancer  --name=dev-ui-loadbalancer
kubectl get service -n devui
kubectl describe service dev-ui-loadbalancer -n devui
kubectl delete service dev-ui-loadbalancer
kubectl delete -f deployment.yaml

