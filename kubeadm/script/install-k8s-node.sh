#!/bin/bash

set -e

# ===== OPTIONS =====
K8S_VERSION=${1:-"v1.35"}
INSTALL_KUBECTL=${2:-"no"}
COPY_KUBECONFIG=${3:-"no"}

echo "Using Kubernetes Version: $K8S_VERSION"

# ===== INSTALL DEPENDENCIES =====
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# ===== ADD REPO =====
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/$K8S_VERSION/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/$K8S_VERSION/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

# ===== INSTALL K8S =====
sudo apt-get update

if [ "$INSTALL_KUBECTL" = "yes" ]; then
  sudo apt-get install -y kubelet kubeadm kubectl
else
  sudo apt-get install -y kubelet kubeadm
fi

sudo apt-mark hold kubelet kubeadm kubectl

# ===== CONTAINERD =====
sudo apt install -y containerd
sudo mkdir -p /etc/containerd

containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' \
| sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd

# ===== SYSTEM CONFIG =====

# Disable swap
sudo swapoff -a
sudo sed -i '/\sswap\s/s/^/#/' /etc/fstab

# Load required kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Persist modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Set sysctl params (RUNTIME)
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.bridge.bridge-nf-call-iptables=1
sudo sysctl -w net.bridge.bridge-nf-call-ip6tables=1

# Persist sysctl settings
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl
sudo sysctl --system

# IMPORTANT: Force correct IP(Vagrant)
IP=$(hostname -I | awk '{print $2}')

sudo sed -i "s|^KUBELET_EXTRA_ARGS=.*|KUBELET_EXTRA_ARGS=--node-ip=$IP|" /etc/default/kubelet

sudo systemctl daemon-reexec
sudo systemctl restart kubelet

echo "Kubernetes setup completed!"