# 🚀 Kubernetes Cluster Setup using Kubeadm (Manual + Automation)

This project provides a **step-by-step Kubernetes cluster setup** using **kubeadm**, along with:

* ✅ Manual setup commands
* ✅ Automated Bash script
* ✅ Ansible playbook

---

## 📌 Features

* Kubernetes installation using official repo
* Container runtime: containerd
* Swap disable & system configuration
* Network configuration (IP forwarding)
* kubeadm cluster initialization
* Optional kubeconfig export to local machine
* Version selection support

---

## 🧰 Requirements

* Ubuntu 20.04 / 22.04
* Root or sudo access
* Internet connection

---

## ⚙️ Manual Installation Steps

### 1. Install Dependencies

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

---

### 2. Add Kubernetes Repository

```bash
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

---

### 3. Install Kubernetes Components

```bash
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

---

### 4. Install containerd

```bash
sudo apt install containerd -y
sudo mkdir -p /etc/containerd

containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' \
| sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd
```

---

### 5. System Configuration

```bash
sudo swapoff -a
sudo sed -i '/\sswap\s/s/^/#/' /etc/fstab
```
```bash
sudo modprobe br_netfilter

sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
sudo bash -c 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables'
sudo bash -c 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables'
```

---

### 6. Initialize Cluster

```bash
sudo kubeadm init \
--apiserver-advertise-address <MASTER_IP> \
--pod-network-cidr "10.244.0.0/16" \
--upload-certs
```

---

### 7. Configure kubectl

```bash
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## 🛠️ Automation Options

### 🔹 Bash Script

```bash
chmod +x install-k8s.sh
./install-k8s.sh
```

---

### 🔹 Ansible Playbook

```bash
ansible-playbook playbook.yml
```

---

## 🔥 Optional Features

* Export kubeconfig to local machine
* Skip kubectl install on control-plane
* Select Kubernetes version

---

## ⭐ Support

If you find this project helpful, please give it a star ⭐ on GitHub.

---

## 🌐 Connect With Me

<div align="center">
  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/shaikh-muhammad-ajaz)
[![Email](https://img.shields.io/badge/Email-shaikhajaz38000@gmail.com-red?style=for-the-badge&logo=gmail&logoColor=white)](mailto:shaikhajaz38000@gmail.com)
[![YouTube](https://img.shields.io/badge/YouTube-Subscribe-red?style=for-the-badge\&logo=youtube\&logoColor=white)](https://www.youtube.com/@devopswithajaz)
</div>

<div align="center">

[![Upwork](https://img.shields.io/badge/Upwork-Hire%20Me-6FDA44?style=for-the-badge&logo=upwork&logoColor=white)](https://upwork.com/freelancers/muhammadajaz)
[![Fiverr](https://img.shields.io/badge/Fiverr-Order%20Now-1DBF73?style=for-the-badge&logo=fiverr&logoColor=white)](https://www.fiverr.com/ajazshaikh3800)
</div>

---

<div align="center">
  
### 💡 "Turning ideas into production-ready systems."

![Profile Views](https://komarev.com/ghpvc/?username=Ajaz3800&color=brightgreen&style=flat-square)
[![GitHub followers](https://img.shields.io/github/followers/Ajaz3800?label=Follow&style=social)](https://github.com/Ajaz3800)

</div>