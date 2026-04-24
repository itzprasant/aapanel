# aaPanel Installer Script

This repository contains a bash script to install and manage aaPanel - a control panel for web hosting management. The script automates the installation process, updates, debugging, error fixing, and basic virus/malware cleanup for aaPanel.

## aaPanel Overview

aaPanel is a free and open-source web hosting control panel that simplifies server management tasks, offering features for web hosting, database management, domain management, and more. It provides a user-friendly interface for server administration.

## Minimum Requirements

- Operating System: Ubuntu 16.04/18.04/20.04, Debian 9/10, CentOS 7/8
- Processor: 1 GHz CPU
- RAM: 512 MB RAM
- Disk Space: 1 GB available disk space
- Internet Connection

## Supported Operating Systems

aaPanel can be installed on the following operating systems:
- Ubuntu 16.04/18.04/20.04
- Debian 9/10
- CentOS 7/8

## Getting a VPS/Dedicated Server from Whiscloud.com

[CLYTRIX](https://clytrix.com) offers VPS hosting/ Dedicated Server services at affordable prices. To purchase a VPS:

1. Visit [CLYTRIX](https://clytrix.com) website.
2. Browse available VPS/Dedicated Server plans and select one that suits your requirements.
3. Proceed to checkout and complete the payment process.
4. Once payment is processed, you will receive an email with Server login details.

## Connecting to your VPS/Dedicated via SSH using PuTTY

PuTTY is a popular SSH client for Windows that allows connecting to a remote server. Here's how to connect using PuTTY:

1. Download and install [PuTTY](https://www.putty.org/).
2. Open PuTTY and enter your VPS IP address in the "Host Name" field.
3. Set the port to 22 (default for SSH).
4. Choose the connection type as SSH.
5. Click "Open" to initiate the connection.
6. You will be prompted for a username (usually "root") and password provided by your VPS provider.

Note: It's recommended to change the default SSH port for security reasons.

## Installation

**For Installation in *Ubuntu/Deepin* Run**
```
wget -O ubuntu.sh https://raw.githubusercontent.com/itzprasant/aapanel/main/ubuntu.sh && chmod 755 ubuntu.sh && sudo ./ubuntu.sh
```

**For Installation in *Centos/AlmaLinux* Run**
```
wget -O alma.sh https://raw.githubusercontent.com/itzprasant/aapanel/main/redhat.sh && chmod 755 redhat.sh && sudo ./redhat.sh
```

[Click Here For All Management Command](https://github.com/itzprasant/aapanel/blob/main/manage.md).

For Any Developement Regarding Queries Contact Us - info@gleyon.com

Visit Our Website - https://gleyon.com
