# k3os-internet-box
## Description
This fork of [k3os](https://github.com/rancher/k3os) project is intended to run on x86_64 Internet Box routers sold by Swisscom.

## Installation and Configuartion
Installation is done through an ISO file. The configuration of the OS is held by a single cloud-init file. [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) and [Helm](https://github.com/helm/helm) installation is automated with short shell scripts located in a gist repository. These scripts are embedded into the cloud-init file, which can be found [here](https://gist.github.com/Alpostros/414f9630a2629589de71a2ca736072ed). 

There are 2 ways to install k3os:
### Booting From The Live ISO
Installation is done by booting with the live iso file and providing the config.yaml file that is located in the machine or as a URL. To do this, the we need to log on the machine as ```rancher``` user without a password, and then use ```sudo k3os install command``` to proceed with the installation. This installation method wipes the entire disk and not very ideal as routers are probably configured without a screen attached. After the installation we need to unmount the installation disk and reboot.

### Using Bootstrapped Installation Script
The other installation option is to use [bootstrapped installation script](https://github.com/rancher/k3os#bootstrapped-installation) on a Linux device:
```shell
curl -S https://raw.githubusercontent.com/rancher/k3os/master/install.sh > install.sh

sudo bash install.sh --config https://gist.githubusercontent.com/Alpostros/414f9630a2629589de71a2ca736072ed/raw/27c285fec52b38039a8c2a8f45472d4cd538718e/config.yaml /dev/sda https://github.com/rancher/k3os/releases/download/v0.21.5-k3s2r1/k3os-amd64.iso
```
We need to provide the config file, disk to install k3os and the URL of the ISO file. After the installation we need to unmount the installation disk and reboot.

We can also use the --takeover flag in this installation script, which will install k3OS to the current root and override the grub.cfg. After a reboot of the system k3OS will then delete all files on the root partition that are not k3OS and then shutdown. This mode is particularly handy when creating cloud images.

### Information About Kubernetes Dashboard and HELM Installation Scripts
Kubernetes Dasboard installation and configuration script pulls [2 configuration files](https://gist.github.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6) from a gist repository for one admin and one read-only user. Dashboard is installed with [recommended installation](https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml). After applying the configuration for the users, the admin token is saved to admin-user-secret file under /home/rancher/dashboard directory. 

Helm and [DHCPD](https://artifacthub.io/packages/helm/pnnl-miscscripts/dhcpd) installation consists of a modified get-helm script(check under issues), [dhcpd installation scripts](https://gist.github.com/Alpostros/414f9630a2629589de71a2ca736072ed#file-install-helm-and-configure-dhcpd-sh) and [configuration files](https://gist.github.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad) which are also pulled from a gist repository.

## Testing Environment
To install, configure and test k3os, I created a VM on my [TrueNAS Core](https://www.truenas.com/truenas-core/) home-server. TrueNAS Core is a Linux OS (based on FreeBSD) which is mainly built for NAS applications, but it also provides creation of VM's and jails. It uses KVM hypervisor for virtualization. An x86_64 VM with 1 core CPU, 2048MB of RAM and 10GB of disk space has been allocated for testing.

## Handling Updates
In the [update section of the k3os repository]()

## Gist URL's of Used Scripts

