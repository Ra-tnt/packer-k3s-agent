#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make
curl -Ls get.docker.com | sh
sudo usermod -aG docker ubuntu
export K3S_HOST=controlplane.bryan.dobc
export K3S_URL=http://$K3S_HOST:6443
export K3S_TOKEN=$(curl http://$K3S_HOST:8765/node)
echo $K3S_TOKEN
curl -sfL https://get.k3s.io | sh -
