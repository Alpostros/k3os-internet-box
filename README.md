# k3os-internet-box
## Description
This fork of [k3os](https://github.com/rancher/k3os) project is intended to run on x86_64 Internet Box routers sold by Swisscom (Interview Assignment).

## Installation and Configuartion
Installation is done through an ISO file. The configuration of the OS is held by a single cloud-init file. [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) and [Helm](https://github.com/helm/helm) installation is automated with short shell scripts located in a gist repository. These scripts are embedded into the cloud-init file, which can be found [here.](https://gist.github.com/Alpostros/ccace77e281038ade238299f078bec1f) 

There are 3 ways to install k3os:
### Booting From The Live ISO
Installation is done by booting with the live iso file and providing the config.yaml file that is located in the machine or as a URL. To do this, you need to log on to the machine as rancher user without a password (if you are using the remastered iso, the password would be "verysecure", which is defined in the config), and then use ```sudo k3os install``` command to proceed with the installation. After the installation, you need to unmount the installation disk and reboot.
### Using Bootstrapped Installation Script
The other installation option is to use [bootstrapped installation script](https://github.com/rancher/k3os#bootstrapped-installation) on a Linux device:
```shell
Usage: ./install.sh [--force-efi] [--debug] [--tty TTY] [--poweroff] [--takeover] [--no-format] [--config https://.../config.yaml] DEVICE ISO_URL

curl -S https://raw.githubusercontent.com/rancher/k3os/master/install.sh > install.sh

./install.sh --config https://gist.githubusercontent.com/Alpostros/ccace77e281038ade238299f078bec1f/raw/cc61b10fe985ded947702bc530d35e0d204e30c7/config.yaml /dev/sda https://github.com/rancher/k3os/releases/download/v0.21.5-k3s2r1/k3os-amd64.iso
```
You need to provide the cloud-init config file, disk to install k3os and the URL of the ISO file. After the installation you need to reboot. If you provide the link of the [remastered iso]() release, you do not need to provide the cloud-init config file.

You can also use the ```--takeover``` flag in this installation script, which will install k3OS to the current root and override the grub.cfg. After a reboot of the system k3OS will then delete all files on the root partition that are not k3OS and then shutdown. This mode is particularly handy when creating cloud images.

###  Using the custom ISO file
There is also an option to install k3os by using the [remastered iso](insert-link-here) that has been packed with the cloud-init config file. With this installation, you don't need to provide any config file like the other methods. You just need to ssh into the machine, use the [bootstrapped installation script](#using-bootstrapped-installation-script) or use ```sudo k3os install``` command mentioned in [booting from the live iso](#booting-from-the-live-iso) section. You can also log in as rancher user with password "verysecure".


### Information About Kubernetes Dashboard and HELM Installation Scripts
Kubernetes Dashboard installation and configuration script pulls [2 configuration files](https://gist.github.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6) from a gist repository for one admin and one read-only user. Dashboard is installed with a [modified version](https://gist.github.com/Alpostros/ccace77e281038ade238299f078bec1f#file-kubernetes-dashboard-config-yaml) of the [recommended installation](https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml) script, where the kubernetes-dashboard service type has been changed to NodePort and assigned a port (30443) for accessing the dashboard easily for testing purposes. After applying the configuration for the users and installing the dashboard, the admin token is saved to admin-user-secret file under /home/rancher/dashboard directory. Dashboard can be accessed on ```https://<device_ip>:30443```.

Helm and [DHCPD](https://artifacthub.io/packages/helm/pnnl-miscscripts/dhcpd) installation consists of a modified get-helm script, [dhcpd installation scripts](https://gist.github.com/Alpostros/ccace77e281038ade238299f078bec1f#file-install-helm-dhcpd-sh) and [configuration files](https://gist.github.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad) which are also pulled from a gist repository.

## Testing Environment
To install, configure and test k3os, I created a VM on my [TrueNAS Core](https://www.truenas.com/truenas-core/) home-server. TrueNAS Core is a Linux OS (based on FreeBSD) which is mainly built for NAS applications, but it also provides creation of VM's and jails. It uses KVM hypervisor for virtualization. An x86_64 VM with 1 core CPU, 2048MB of RAM and 10GB of disk space has been allocated for testing.

## Handling Updates
As mentioned in the original [rancher/k3os](https://github.com/rancher/k3os#automatic-upgrades) repository, integration with [rancher/system-upgrade-controller](https://github.com/rancher/system-upgrade-controller) has been implemented as of v0.9.0. To enable a k3OS node to automatically upgrade from the latest GitHub release you will need to run the following command:  
```shell
kubectl label nodes -l k3os.io/mode k3os.io/upgrade=latest
```
 
The upgrade controller will then spawn an upgrade job that will drain most pods, upgrade the k3OS content under /k3os/system, and then reboot. The system should come back up running the latest kernel and k3s version bundled with k3OS and ready to schedule pods.
## Gist URL's of Used Scripts

config (cloud-init), get-helm, Helm and DHCPD installation script, kubernetes dashboard installation script and configuration files can be found [here.](https://gist.github.com/Alpostros/ccace77e281038ade238299f078bec1f) 

Kubernetes Dashboard admin and read only user configuration files can be found [here.](https://gist.github.com/Alpostros/fbcbbc6f8dac482a5d306841200c53d6)

dhcpd-values can be found [here.](https://gist.github.com/Alpostros/0fc9825cffdad80be3a9fb95581e37ad)
