#!/usr/bin/env bash

#### App Jenkins
 mkdir /opt/jenkins
 chown -R vagrant /opt/jenkins
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
mkdir -p /opt/nexus
#kubectl create namespace nexus
kubectl create -f /vagrant/namespaces/nexus.yaml
kubectl config set-context --current --namespace=nexus
kubectl get namespaces

kubectl create -f /vagrant/nexus/nexus.yaml
kubectl get po -n nexus
#https://support.sonatype.com/hc/en-us/articles/227256688-How-do-I-configure-the-Nexus-Jenkins-Plugin


## For Jenkins Kubernetes plugin
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
#clusterrolebinding.rbac.authorization.k8s.io/permissive-binding created


## PostgreSQL
# https://severalnines.com/blog/using-kubernetes-deploy-postgresql
kubectl create -f  /vagrant/postgres/postgres-storage.yaml
#persistentvolume/postgres-pv-volume created
#persistentvolumeclaim/postgres-pv-claim created
kubectl create -f  /vagrant/postgres/postgres-configmap.yaml
#configmap/postgres-config created
kubectl create -f /vagrant/postgres/postgres-deployment.yaml
#deployment.extensions/postgres created
kubectl create -f /vagrant/postgres/postgres-service.yaml
#service/postgres created
kubectl get svc postgres

## kubectl delete service postgres
## kubectl delete deployment postgres
## kubectl delete configmap postgres-config
## kubectl delete persistentvolumeclaim postgres-pv-claim
## kubectl delete persistentvolume postgres-pv-volume



### SonarQube
mkdir -p /opt/sonarqube/data/
mkdir -p /opt/sonarqube/extensions/
## https://medium.com/@akamenev/running-sonarqube-on-azure-kubernetes-92a1b9051120
kubectl apply -f /vagrant/sonarqube/sonar.yml
#persistentvolume/sonar-vol-pv-data created
#persistentvolumeclaim/sonar-vol-pvc-data created
#persistentvolume/sonar-vol-pv-ext created
#persistentvolumeclaim/sonar-vol-pvc-ext created
#secret/postgres unchanged
#deployment.extensions/sonar-dep created
#service/sonar-svc created
#ingress.networking.k8s.io/my-ingress created




