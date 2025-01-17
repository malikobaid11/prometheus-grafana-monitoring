# Prometheus and Grafana Setup

This repository provides step-by-step instructions for configuring Prometheus and Grafana for system monitoring, including setting up Node Exporter on monitored servers.

---

## Folder Structure

```
.
├── README.md
├── prometheus
│   ├── prometheus.yml
│   └── systemd
│       ├── node_exporter.service
│       └── prometheus.service
├── grafana
│   └── setup_instructions.txt
└── scripts
    ├── install_prometheus.sh
    ├── install_grafana.sh
    ├── install_node_exporter.sh
    └── configure_firewall.sh
```

---

## Prerequisites

- A Linux environment (Debian-based).
- Administrative privileges.

---

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

---

### 2. Installing Node Exporter

Run the script `scripts/install_node_exporter.sh` or execute the steps below manually:

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz
tar xvf node_exporter-0.16.0.linux-amd64.tar.gz
sudo cp node_exporter-0.16.0.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-0.16.0.linux-amd64*
```

Create a systemd service for Node Exporter:

```bash
sudo cp prometheus/systemd/node_exporter.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter
```

---

### 3. Installing Prometheus

Run the script `scripts/install_prometheus.sh` or execute the steps below manually:

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz
tar xfz prometheus-2.2.1.linux-amd64.tar.gz
cd prometheus-2.2.1.linux-amd64
sudo cp prometheus promtool /usr/local/bin/
sudo cp -r consoles console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
cd .. && rm -rf prometheus-2.2.1.linux-amd64
```

Create a Prometheus configuration file and systemd service:

```bash
sudo cp prometheus/prometheus.yml /etc/prometheus/
sudo cp prometheus/systemd/prometheus.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus
```

---

### 4. Installing Grafana

Run the script `scripts/install_grafana.sh` or execute the steps below manually:

```bash
wget https://dl.grafana.com/oss/release/grafana_5.0.4_amd64.deb
sudo apt-get install -y adduser libfontconfig
sudo dpkg -i grafana_5.0.4_amd64.deb
sudo systemctl enable --now grafana-server
```

---

### 5. Configuring Prometheus for Multiple Servers

Edit `/etc/prometheus/prometheus.yml` to include monitored servers:

```yaml
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100', '172.16.102.162:9100']
```

Restart Prometheus:

```bash
sudo systemctl restart prometheus
```

---

### 6. Accessing Dashboards

- Prometheus: `http://<server-ip>:9090`
- Grafana: `http://<server-ip>:3000`
  - Default Username: `admin`
  - Default Password: `admin`

---

## Additional Notes

- For further details, refer to the `grafana/setup_instructions.txt`.
- Disable firewall if necessary using `scripts/configure_firewall.sh`.

---

