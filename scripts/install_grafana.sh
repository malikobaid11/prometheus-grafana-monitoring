#!/bin/bash

# Install dependencies
sudo apt-get install -y adduser libfontconfig

# Download and install Grafana
wget https://dl.grafana.com/oss/release/grafana_5.0.4_amd64.deb
sudo dpkg -i grafana_5.0.4_amd64.deb

# Enable and start Grafana
sudo systemctl enable --now grafana-server

