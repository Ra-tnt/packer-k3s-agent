#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make
curl -Ls get.docker.com | sh
sudo usermod -aG docker ubuntu
export K3S_HOST=controlplane.bryan.dobc
export K3S_TOKEN=wibble
export K3S_URL=http://$K3S_HOST:6443
curl -sfL https://get.k3s.io | sh -

sudo touch /etc/systemd/system/configK3s.service
sudo chmod a+rw /etc/systemd/system/configK3s.service
sudo chmod a+rw /etc/systemd/system/k3s-agent.service.env

cat << EOF > /etc/systemd/system/configK3s.service
[Unit]
Description=Configures the environment for k3s
After=k3s.target

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=printf "K3S_TOKEN=%s\nK3S_URL=%s" "$(curl -Ss http://controlplane.bryan.dobc:8765/node)" "$K3S_URL" >> /etc/systemd/system/k3s-agent.service.env

[Install]
WantedBy=multi-user.target
EOF

