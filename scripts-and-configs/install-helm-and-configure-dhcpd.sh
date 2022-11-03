#!/bin/bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
curl https://gist.githubusercontent.com/Alpostros/ccace77e281038ade238299f078bec1f/raw/b1db9e9cd5aa894a8eec99fdfdc3079930a62ea9/get-helm.sh > get-helm.sh
chmod 700 get-helm.sh
./get-helm.sh
mkdir /home/rancher/dhcpd
helm repo add pnnl-miscscripts https://pnnl-miscscripts.github.io/charts
curl -S https://gist.githubusercontent.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad/raw/1ba2c7df40d48e7dec56a88bbb553f15d3243ef9/dhcpd-values.yaml > /home/rancher/dhcpd/dhcpd-values.yaml
helm install dhcpd pnnl-miscscripts/dhcpd --version 0.1.7 -f /home/rancher/dhcpd/dhcpd-values.yaml --namespace dhcpd --create-namespace
helm status "dhcpd"
echo "Helm and dhcpd has been installed!"