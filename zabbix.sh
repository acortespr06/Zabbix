#!/usr/bin/env bash

# Detect Linux distribution and version
if [ -f /etc/os-release ]; then
    # Amazon Linux, Red Hat Enterprise Linux, CentOS, Oracle Linux
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # Ubuntu
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# Install Zabbix agent
if [ "$OS" = "Ubuntu" ]; then
    wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+$(lsb_release -cs)_all.deb
    dpkg -i zabbix-release_6.0-1+$(lsb_release -cs)_all.deb
    apt update
    apt -y install zabbix-agent
elif [[ "$OS" = "Red Hat Enterprise Linux" || "$OS" = "CentOS" ]]; then
    yum -y install https://repo.zabbix.com/zabbix/6.0/rhel/$VER/x86_64/zabbix-release-6.0-1.el$VER.noarch.rpm
    yum -y install zabbix-agent
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# Update Zabbix agent configuration file
sed -i 's/^LogFile=.*/LogFile=\/var\/log\/zabbix\/zabbix_agentd.log/g' /etc/zabbix-agent/zabbix_agentd.conf
sed -i 's/^Server=.*/Server=zabbix.nexthorizon.me/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^ServerActive=.*/ServerActive=zabbix.nexthorizon.me/g' /etc/zabbix/zabbix_agentd.conf
HOSTNAME=$(hostname)
sed -i 's/^# Hostname=/Hostname=/g' /etc/zabbix/zabbix_agentd.conf
sed -i "/^Hostname=/ s/.*/Hostname=$HOSTNAME/g" /etc/zabbix/zabbix_agentd.conf

# Restart Zabbix agent service
systemctl restart zabbix-agent
