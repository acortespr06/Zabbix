# Copyright (c) 2021-2023 acortes
# Author: acortes
# License: MIT
# Define variables

$ZabbixServer = "zabbix.example.com"
$ZabbixServerPort = "10050"
$ZabbixHostname = "$env:COMPUTERNAME"

# Download Zabbix agent MSI installer
$Url = "https://repo.zabbix.com/zabbix/5.4/windows/x86_64/zabbix_agent-5.4.3-windows-amd64-openssl.msi"
$Output = "$env:TEMP\zabbix_agent.msi"
Invoke-WebRequest -Uri $Url -OutFile $Output

# Install Zabbix agent in unattended mode
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$Output`" /qn SERVER=`"$ZabbixServer`" SERVERPORT=`"$ZabbixServerPort`" HOSTNAME=`"$ZabbixHostname`"" -Wait

