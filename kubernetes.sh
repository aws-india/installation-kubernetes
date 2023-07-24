sudo apt-get update

echo "....................swapoff"

swapoff -a

echo "....................Installing sshpass "

sudo apt-get install -y sshpass   

echo "....................openssh server installation"
sudo apt-get install -y openssh-server

sudo apt-get update
echo "....................Docker installtion"

sudo apt-get install docker

systemctl daemon-reload
systemctl restart docker

sudo apt-get update

sleep 5s

sudo apt-get install -y ca-certificates curl
sleep 5s
sudo apt-get install -y apt-transport-https
sleep 5s

echo ".....................Installing kubeadm kubelet kubectl"
sudo mkdir /etc/apt/keyrings

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
sleep 30s

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sleep 5s

sudo apt-get install -y kubeadm
sleep 5s

sudo apt-get install -y kubectl
sleep 5s
sudo apt-get install -y kubelet
sleep 5s

echo ".......................Restart kubelet"

systemctl daemon-reload
systemctl restart kubelet

sudo apt-get update

echo ".......................Execute sucessfully"

