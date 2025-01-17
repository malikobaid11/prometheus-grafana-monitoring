## Setup Instructions

### 1. Preparing the Environment

Run the following commands to create necessary users and directories:

```bash
sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
```
### 2. Installing Node Exporter

Run the script `scripts/install_node_exporter.sh` or execute the steps below manually:

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz
tar xvf node_exporter-0.16.0.linux-amd64.tar.gz
sudo cp node_exporter-0.16.0.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-0.16.0.linux-amd64*
```
