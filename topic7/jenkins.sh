#!/usr/bin/env bash

#### App Jenkins
# mkdir /opt/jenkins
# chown -R vagrant /opt/jenkins
install -d -o vagrant -g vagrant /opt/jenkins


## Create namespace jenkins
kubectl create -f /vagrant/namespaces/jenkins.yaml
kubectl config set-context --current --namespace=jenkins
kubectl get namespaces

## Volume shared between Containers within a Pod
kubectl apply -f /vagrant/volumes/jenkins_pv.yaml
kubectl apply -f /vagrant/volumes/jenkins_pvc.yaml
kubectl apply -f /vagrant/jenkins/jenkins_d.yaml
kubectl apply -f /vagrant/jenkins/jenkins_s.yaml
kubectl apply -f /vagrant/jenkins/jenkins_ingress.yaml
# kubectl get persistentvolume
# kubectl get persistentvolumeclaims



## Setup Nexus OSS On Kubernetes
#https://devopscube.com/setup-nexus-kubernetes/

#kubectl create namespace nexus
kubectl create -f /vagrant/namespaces/nexus.yaml
kubectl config set-context --current --namespace=nexus
kubectl get namespaces

kubectl create -f /vagrant/nexus/nexus.yaml
kubectl get po -n nexus

#https://support.sonatype.com/hc/en-us/articles/227256688-How-do-I-configure-the-Nexus-Jenkins-Plugin





