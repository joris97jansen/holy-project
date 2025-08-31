#!/usr/bin/env bash
set -euo pipefail

# 1) install Ansible and git
sudo apt update
sudo apt-get install -y --no-install-recommends git ansible

# 2) clone the holy-project repository to /opt/code
sudo mkdir -p /opt/code
sudo chown "$USER":"$USER" /opt/code
git clone https://github.com/joris97jansen/holy-project.git /opt/code/holy-project

# 3) run your Ansible play right away (prompts for Vault password)
#    -i "localhost," + -c local runs on this machine
cd /opt/code/holy-project
ansible-playbook server.yml --ask-vault-pass

# How to run the script from your local machine:
# scp bootstrap.sh root@<IP>:/root/bootstrap.sh
# ssh root@<IP> 'chmod +x /root/bootstrap.sh && /root/bootstrap.sh'
