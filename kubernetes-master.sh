#!/bin/sh

echo 
echo "**** init cluster ****"
echo 

rm /etc/containerd/config.toml
systemctl restart containerd

kubeadm config images pull
kubeadm init

mkdir -p $HOME/.kube 
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown  $(id -u):$(id -g)  $HOME/.kube/config

echo 
echo "**** autocompletion kubectl ****"
echo 

echo "source <(kubectl completion bash)" >> $HOME/.bashrc

echo 
"**** pod network - weave net ****"
echo 

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

echo 
echo "**** install helm ****"
echo 

curl -L https://git.io/get_helm.sh | bash

helm init

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

echo 
echo "**** view status cluster ****"
echo

kubectl get nodes,svc,deploy,rs,rc,po -o wide

echo 
echo "**** add node worker with token ****"
echo 

kubeadm token create --print-join-command

echo 
echo "finish install"
