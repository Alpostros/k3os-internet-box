#!/bin/bash
mkdir /home/rancher/dashboard && cd /home/rancher/dashboard
kubectl apply -f https://gist.githubusercontent.com/Alpostros/ccace77e281038ade238299f078bec1f/raw/b1db9e9cd5aa894a8eec99fdfdc3079930a62ea9/kubernetes-dashboard-config.yaml
kubectl apply -f https://gist.githubusercontent.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6/raw/c81c5c276fbea7cd7684ab4810f3ea9e09b9698a/dasboard-admin.yaml
kubectl apply -f https://gist.githubusercontent.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6/raw/c81c5c276fbea7cd7684ab4810f3ea9e09b9698a/dashboard-read-only.yaml
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode > admin-user-secret
echo "Kubernetes Dashboard has been installed and configured! Secret key is located at /home/rancher/dashboard/admin-user-secret"