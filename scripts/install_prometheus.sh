#!/bin/bash

# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz
tar xfz prometheus-2.2.1.linux-amd64.tar.gz

# Install binaries
cd prometheus-2.2.1.linux-amd64
sudo cp prometheus promtool /usr/local/bin/
sudo cp -r consoles console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
cd .. && rm -rf prometheus-2.2.1.linux-amd64

