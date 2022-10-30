# k3os-internet-box
## Description
This fork of [k3os](https://github.com/rancher/k3os) project is intended to run on x86_64 Internet Box routers sold by Swisscom.

## Installation and Configuartion
Installation is done through an ISO file. The configuration of the OS is held by a single cloud-init file. [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) and [Helm](https://github.com/helm/helm) installation is automated with short shell scripts located in a gist repository. These scripts are embedded into the cloud-init file, which can be found [here](https://gist.github.com/Alpostros/414f9630a2629589de71a2ca736072ed). 

### Information About Kuberneted Dashboard and HELM Installation Scripts
Kubernetes Dasboard installation and configuration script pulls [2 configuration files](https://gist.github.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6) from a gist repository for one admin and one read-only user. Dashboard is installed with [recommended installation](https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml). After applying the configuration for the users, the admin token is saved to admin-user-secret file under /home/rancher/dashboard directory. 

HELM and [DHCPD](https://artifacthub.io/packages/helm/pnnl-miscscripts/dhcpd) installation consists of a modified get-helm script(check under issues), [dhcpd installation scripts](https://gist.github.com/Alpostros/414f9630a2629589de71a2ca736072ed#file-install-helm-and-configure-dhcpd-sh) and [configuration files](https://gist.github.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad) which are also pulled from a gist repository.

## Testing Environment
To install, configure and test k3os, I created a VM on my [TrueNAS Core](https://www.truenas.com/truenas-core/) home-server. TrueNAS Core is a Linux OS (based on FreeBSD) which is mainly built for NAS applications, but it also provides creation of VM's and jails. It uses KVM hypervisor for virtualization. An x86_64 VM with 1 core CPU, 2048MB of RAM and 10GB of disk space has been allocated for testing.

## Issues 

One of the issues I came accross is the lack of openssl installation in the k3os image. The Kubernetes Dashbaord uses openssl to create certificates to access the WEB GUI created with openssl, which resulted in a invalid certificate error in my browser. 

I tried to install openssl, but openssl depends on Perl 5, and Perl 5 depens on make, and make depends on gcc, which are not pre-installed in k3os image. Also there is no c compiler on the k3os image.

As a workaround, I created the certificates on another machine and uploaded them to the GitHub repository and used wget to pull them. 


## Handling Updates
In the [update section of the k3os repository]()
