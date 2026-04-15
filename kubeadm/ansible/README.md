# 🚀 Kubernetes Cluster Setup with Kubeadm (Ansible Automated)

This project demonstrates a **production-style Kubernetes cluster setup** using:

* ⚙️ kubeadm (cluster bootstrap)
* 🤖 Ansible (full automation)
* 📦 containerd (container runtime)

---

## 📁 Project Structure

```bash
kubeadm/ansible/
├── ansible.cfg
├── inventory/
│   └── hosts.ini
├── playbook.yml
└── roles/
    ├── common/
    ├── containerd/
    ├── kubernetes/
    ├── master/
    └── worker/
```

---

## 🧠 What This Project Does

This Ansible setup will:

* Disable swap (required for Kubernetes)
* Configure system settings (IP forwarding, kernel modules)
* Install containerd runtime
* Install Kubernetes components (kubeadm, kubelet, kubectl)
* Initialize control plane (master node)
* Join worker nodes to cluster
* Configure kubectl access

---

## 🧰 Requirements

* Ubuntu 20.04 / 22.04
* Ansible installed on control machine
* SSH access to all nodes
* Minimum resources:

  * Master: 4GB RAM, 2 CPU
  * Worker: 2GB RAM

---

## ⚙️ Inventory Configuration

Edit:

```bash
inventory/hosts.ini
```

Example:

```ini
[master]
master ansible_host=192.168.56.10

[workers]
worker1 ansible_host=192.168.56.11

[all:vars]
ansible_user=vagrant
```

---

## 🚀 How to Run

### 1️⃣ Navigate to ansible folder

```bash
cd kubeadm/ansible
```

---

### 2️⃣ Run Playbook

```bash
ansible-playbook playbook.yml
```

---

## 🔍 Verify Cluster

Login to master node:

```bash
kubectl get nodes
```

Expected output:

```bash
NAME       STATUS   ROLES           AGE   VERSION
master     Ready    control-plane   XX    v1.xx.x
worker1    Ready    <none>          XX    v1.xx.x
```

---

## 🌐 Install Network Plugin (Important)

After cluster setup, install CNI plugin:

```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

---

## 🛠️ Roles Explanation

### 🔹 common

* Disable swap
* Kernel configuration
* System tuning

### 🔹 containerd

* Install and configure container runtime

### 🔹 kubernetes

* Install kubeadm, kubelet, kubectl

### 🔹 master

* Initialize Kubernetes cluster
* Generate join command
* Configure kubectl

### 🔹 worker

* Join nodes to cluster

---

## ⚠️ Troubleshooting

### ❌ Node Not Ready

* Check CNI plugin installed
* Restart kubelet:

```bash
sudo systemctl restart kubelet
```

---

### ❌ kubeadm init fails

* Check swap is disabled:

```bash
free -h
```

---

### ❌ Pods not starting

```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

## 📌 Future Improvements

* 🔐 Add Kyverno (Policy Engine)
* 🛡️ Add Falco (Runtime Security)
* 📊 Add Prometheus + Grafana (Monitoring)
* 🚀 Add ArgoCD (GitOps)
* 🔄 CI/CD Integration (GitHub Actions)

---

## 💡 Why This Project?

This project showcases:

* Real-world Kubernetes cluster setup
* Infrastructure automation using Ansible
* Understanding of cluster lifecycle management

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