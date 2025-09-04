# holy-project
## The project where we create a single, cheap holy server try to push it to its limits

[![Hetzner](https://intelcorp.scene7.com/is/image/intelcorp/hetzner-article-logo-1280x720:1920-1080?wid=480&hei=270&fmt=webp-alpha)](https://www.hetzner.com/cloud/)

Hetzner is a datacenter operator, offering hosting, cloud, VPS and more.

## The server
The cheap 2 vCPU & 4GB RAM is all we got, and we need the following stuff installed:
- Postgres
- Nginx
- Python
- My Django projects
- ...

It needs to be secure, fast, reliable, easy to maintain and run production code (Django projects).


## Server Setup
In order to setup the server and install the necessary dependencies, we'll use this Repo in combition with Ansible (playbook & vault).

First things first, you have to create a server at Hetzner, and get its IPv4 address.
The settings I used for the server are:
- Location: Helsinki
- Image: Debian 13
- Type: CX22 (2 vCPU, 4GB RAM, 20GB SSD) Intel
- Network: Public IPv4 & disable IPv6
- No SSH key
- Other settings: Default/Empty

After the creation of the Server, you should use the dashboard to login via the web console, and set a root password.
The current login credentials are sent to your email address.


## Install Ansible on your local machine
1. install
2. create shh keys
3. use Ansible Vault to encrypt the SSH keys


### Create the bootstrap file

### Create the Ansible Playbook

### Push code to Github

## Configure local machine
```bash
ansible-playbook local.yml --ask-vault-password --ask-become-pass
```

## Configure the Server
Then, its time to setup the server. The bootstrap file contains a shell script which will install git & ansible, and clone this repo.
Then, it'll run the command necessary to install all requirements and configure the server as we wish.
```bash
 scp bootstrap.sh root@<SERVER_IPV4>:/root/bootstrap.sh
``````

After copying the file, you can run it via SSH:
```bash
 ssh root@<SERVER_IPV4>
```

Make the file an executable:
```bash
 chmod +x /root/bootstrap.sh
```
Then run it:
```bash
 /root/bootstrap.sh
```

## Setup tha cloud
### Generate API Token
### Encrypt API Token
### Run Ansible Playbook (firewall, etc)