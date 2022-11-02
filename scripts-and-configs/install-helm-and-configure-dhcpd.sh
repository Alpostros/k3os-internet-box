#!/bin/bash
curl https://gist.githubusercontent.com/Alpostros/414f9630a2629589de71a2ca736072ed/raw/d26104f4e6c929fa2ef2eb48ff79d8b669445f08/get-helm.sh | bash
mkdir /home/rancher/dhcpd
helm repo add pnnl-miscscripts https://pnnl-miscscripts.github.io/charts
curl -S https://gist.githubusercontent.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad/raw/3d5da891ae5c4825f3b2b80290b562bd2b6a3d1d/dhcpd-values.yaml > /home/rancher/dhcpd/dhcpd-values.yaml
helm install dhcpd pnnl-miscscripts/dhcpd --version 0.1.7 -f /home/rancher/dhcpd/dhcpd-values.yaml --namespace dhcpd --create-namespace
helm status "dhcpd"
echo "Helm and dhcpd has been installed!"