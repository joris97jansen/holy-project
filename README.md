# holy-project

### One cheap server, pushed to its limits 🚀

[![Hetzner](https://intelcorp.scene7.com/is/image/intelcorp/hetzner-article-logo-1280x720:1920-1080?wid=480\&hei=270\&fmt=webp-alpha)](https://www.hetzner.com/cloud/)

Hetzner is a datacenter operator that offers cloud servers, VPS, and bare metal machines.
In this project we take **one cheap cloud server** and see how far we can push it.

---

## The server

We’re keeping it simple and cheap: **2 vCPU, 4 GB RAM, 20 GB SSD**.
On top of that, we want this little machine to run in production, with the following stack:

* PostgreSQL
* NGINX
* Python
* Django project(s)
* (and whatever else we can squeeze in)

**Requirements:** secure, fast, reliable, easy to maintain, and ready for production.

---

## How we set things up

We use **Ansible** to automate the setup and configuration. This repo holds the playbooks and tasks needed to get everything installed, hardened, and running.

### 1. Create your Hetzner server

Settings I used:

* **Location**: Nuremberg
* **Image**: Debian 13
* **Type**: CX22 (2 vCPU, 4 GB RAM, 20 GB SSD, Intel)
* **Networking**: Public IPv4 only (disable IPv6)
* **SSH keys**: none
* Other: defaults

Once created, Hetzner emails you the root password.
You have to log in via the Hetzner dashboard → web console to get started and set a new password for the root user.

---

### 2. Install Ansible on your local machine
The first step after creation of the Server, is ensuring our local machine is ready to handle it.

#### On your PC you’ll need:

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
* Ansible Vault (conmes with the Ansible installation)


#### Create the SSH keys in the .ssh folder
```Bash
ssh-keygen -f ./.ssh
```

Then, we'll need to encrypt the SSH keys using Ansible Vault:

```Bash
ansible-vault encrypt ./.ssh/<NAME_OF_THE_SSH_KEY> ./.ssh/<NAME_OF_THE_SSH_KEY>.pub
```
Choose your password wisely, and/or store it somewhere safe, because you'll need this everytime you'll run the Ansible Playbook or when you want to encrypt/decrypt the file(s).

After that, we'll also have to create a `local.yml` file inside the `vars/` folder.
The content of that file currently looks like this:
```yaml
host_name: "<SERVER_IPV4_ADDRESS>"
```

We'll also encrypt this using Ansible Vault:
```Bash
ansible vault encrypt ./vars/local.yml
```


#### Installation
Now, it's finally time to setup our local machines.
It might look a bit cumbersome and overwhelming, but the whole idea of this setup is that you can now run this script on any machine easily.

```Bash
ansible-playbook local.yml --ask-vault-password --ask-become-pass
```

The playbooks handle things like:

* SSH setup

---

### 3. Bootstrap the server

Now that our local machine is ready, we have to ensure the server is also by pushing the `bootstrap.sh` file to the server.
This script installs Git + Ansible, then clones this repo, and runs the Ansible Playbook for the server.


First we copy the `bootstrap.sh` file to the server:

```bash
scp bootstrap.sh root@<IP>:/root/bootstrap.sh
```

Then we make the script an executable and run it on the server:
```bash
ssh root@<IP> 'chmod +x /root/bootstrap.sh && /root/bootstrap.sh'
```

The script, and therefor the playbook(s) handle things like:

* SSH setup & hardening
* Installing NGINX
* Installing PostgreSQL
* Installing Python and dependencies

---

## Cloud config (Hetzner API)

To automate more (like firewall setup), you’ll need an API token.

1. Generate a Hetzner API token in the Hetzner Cloud dashboard → Security → API Token (read & write access).

2. After that, we'll also have to create a `cloud.yml` file inside the `vars/` folder.
The content of that file currently looks like this:
```yaml
host_name: "<SERVER_IPV4_ADDRESS>"
hcloud_token: "<API_TOKEN>"
```

3. We'll also encrypt this using Ansible Vault:
```Bash
ansible vault encrypt ./vars/cloud.yml
```

4. Run the playbook on your local machine to configure the firewall and .....


```bash
ansible-playbook cloud.yml --ask-vault-password
```

---

## Updating packages

We’ve got a task specifically for keeping packages up-to-date on the server (nginx, postgres, etc).
Run it with the `update` tag:

```bash
ansible-playbook server.yml --tags update
```

This way you don’t need to run the whole playbook, just the updates.

---

## Why this project?

Because running stuff on a **tiny cheap server** is fun.
And also because it’s a great way to learn:

* Ansible
* Hetzner Cloud
* Server hardening & automation
* Running Django apps in production

---

✨ That’s it. One repo, one cheap server, fully automated setup.
Next steps: deploying apps, adding monitoring, backups, and pushing this little box to the limit.

---

