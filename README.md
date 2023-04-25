
# Zabbix Agent Configuration for Linux and Windows

This repository contains instructions and scripts to configure Zabbix agents on Linux and Windows machines.

```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/acortespr06/Zabbix/main/zabbix.sh)"
```


## Prerequisites

Before proceeding, make sure you have the following:

- A Zabbix server up and running
- A Linux or Windows machine that you want to monitor with Zabbix

## Installation

### Linux

To install the Zabbix agent on a Linux machine, run the following commands:

sudo apt-get update
sudo apt-get install zabbix-agent

Once the agent is installed, copy the `zabbix_agentd.conf` file from this repository to `/etc/zabbix/` directory. You may need to modify the configuration file to suit your needs.

Then, restart the Zabbix agent service:


### Windows

To install the Zabbix agent on a Windows machine, download the Zabbix agent installation package from the [official Zabbix website](https://www.zabbix.com/download_agents). Run the installation package and follow the prompts to install the agent.

Once the agent is installed, copy the `zabbix_agentd.conf` file from this repository to `C:\Program Files\Zabbix Agent\` directory. You may need to modify the configuration file to suit your needs.

Then, restart the Zabbix agent service:

1. Open the "Services" app from the Windows Control Panel.
2. Locate the "Zabbix Agent" service.
3. Right-click the service and select "Restart".

## Configuration

After installing the Zabbix agent, you need to configure it to communicate with your Zabbix server. Follow these steps to configure the agent:

1. Log in to the Zabbix web interface.
2. Navigate to "Configuration" > "Hosts" and click "Create host".
3. Enter a name for the host and select "Zabbix agent" as the host interface.
4. Enter the IP address or DNS name of the host and set the port to `10050`.
5. Click "Add" to save the host configuration.
6. Navigate to the "Templates" tab and link the appropriate templates to the host.
7. Save the changes.

## Usage

Once the agent is installed and configured, it will start sending data to your Zabbix server. You can view the data by navigating to "Monitoring" > "Latest data" in the Zabbix web interface.

## Contributing

If you find any issues or have any suggestions for improving the Zabbix agent configuration, feel free to open a GitHub issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
