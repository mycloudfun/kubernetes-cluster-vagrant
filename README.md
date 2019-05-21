# Kubernetes cluster with Vagrant and Ansible

The aim of this project is to build the HA Kubernetes cluster using Kubeadm, Vagrant, and Ansible for the test/learn purpose.
I tried to make it as simple as possible. As a result, you can build your own on-premise Kubernets cluster in a couple of minutes.
It's a good alternative to any cloud based solutions, because its for free (the only limitation is your computer hardware)

## Prerequisities 

* Vagrant (tested on version 2.2.4)
* Ansible (tested on version 2.7.8)
* VirtualBox (tested on version 6.0.6_Ubuntu r129722)
* Comptuer with Linux (tested on Ubuntu 19.04)
* Minimum 8GB RAM and 2x CPU (not tested on smaller machine)
* Kubectl on local PC

## Setup

The cluster spin up 3 Master's nodes, 3 Worker's nodes and one load balancer. By default, it configures Kubernetes v1.14 (if not configured differently). As a network CNI plugin uses Canico.

### Step 1

The first step is to configure ssh keys, which we use later to configure the cluster via Ansible. Run below script to produce them:

```bash
./sshKeys.sh
```

### Step 2

The next step is to configure entries in your local machine. Base setup is made of 3 masters and 3 workes nodes and 1 load balancer. You need the following entries in your **/etc/hosts**

```bash
10.0.0.10 api api.k8s.local api
10.0.0.21 master1 master1.k8s.local
10.0.0.22 master2 master2.k8s.local
10.0.0.23 master3 master3.k8s.local
10.0.0.31 worker1 worker1.k8s.local
10.0.0.32 worker2 worker2.k8s.local
10.0.0.33 worker3 worker3.k8s.local
```

Run below script to configure it:

```bash
$ sudo ./hostsSetup.sh
```

### Step 3

Next step is to create the infrastructure and base servers setup. Thanks to Vagrant, you can do it in one simple command:

```bash
$ vagrant up
```

After a couple of minutes (depending on your internet speed), the infrastructure part will be ready.

### Step 4

Finally, run the below script which invokes the Ansible to configure the whole cluster components:

```bash
$ ./setup.sh
```

Your cluster will be ready in a couple of minutes. The installations script will copy the necessary **kubeconfig**, which you can use later to validate the status of your cluster from your local computer:

```bash
$ kubectl --kubeconfig ansible/buffer/admin.conf get nodes
NAME                STATUS   ROLES    AGE   VERSION
master1.k8s.local   Ready    master   35m   v1.14.2
master2.k8s.local   Ready    master   31m   v1.14.2
master3.k8s.local   Ready    master   30m   v1.14.2
worker1.k8s.local   Ready    <none>   17m   v1.14.2
worker2.k8s.local   Ready    <none>   58s   v1.14.2
worker3.k8s.local   Ready    <none>   41s   v1.14.2
```

## Customization

1. In case you need more hardware resources, edit the Vagrantfile and adjust the configuration settings. 
2. In case you need a different version of the Kubernetes, adjust the value of **kubernetes_version** variable in ansible inventory.