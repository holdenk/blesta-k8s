kubectl create ns blesta
kubectl create -n blesta configmap apache2-config --from-file=apache2=apache2.conf
kubectl apply -n blesta-deployment.yaml
