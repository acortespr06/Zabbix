#!/usr/bin/env bash

# Determine Linux flavor
if [ -f /etc/redhat-release ]; then
    OS="RHEL"
elif [ -f /etc/debian_version ]; then
    if grep -qi "ubuntu" /etc/issue; then
        OS="Ubuntu"
    else
        OS="Debian"
    fi
else
    echo "Unsupported Linux flavor."
    exit 1
fi

# Download appropriate Zabbix agent package
if [ "$OS" == "RHEL" ]; then
    # RHEL/CentOS
    yum update
    yum install wget -y
    wget https://repo.zabbix.com/zabbix/6.0/rhel/$(uname -m)/zabbix-agent-6.0.0-1.el7.$(uname -m).rpm
    yum install zabbix-agent-6.0.0-1.el7.$(uname -m).rpm -y
elif [ "$OS" == "Debian" ] || [ "$OS" == "Ubuntu" ]; then
    # Debian/Ubuntu
    wget https://repo.zabbix.com/zabbix/6.0/pool/main/z/zabbix-release/zabbix-release_6.0-1+$(lsb_release -sc)_all.deb
    dpkg -i zabbix-release_6.0-1+$(lsb_release -sc)_all.deb
    apt-get update
    apt-get install zabbix-agent -y
else
    echo "Unsupported Linux flavor."
    exit 1
fi
