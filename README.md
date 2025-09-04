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
You have to log in via the Hetzner dashboard → web console to get started (set a new password).

---

### 2. Install Ansible on your local machine
The first step after creation of the Server, is ensuring our local machine is ready to handle it.

#### On your PC you’ll need:

* Ansible
* SSH keys (create them if you don’t have them yet)
* Ansible Vault (to encrypt private keys and secrets)

#### Installation
```Bash
ansible-playbook local.yml --ask-vault-password --ask-become-pass
```

The playbooks handle things like:

* SSH setup

---

### 3. Bootstrap the server

Now that our local machine is ready, we have to ensure the server is as well by pushing the `bootstrap.sh` file to the server.
This script installs Git + Ansible, then clones this repo, and runs the setup.


Server setup:

```bash
ansible-playbook server.yml --ask-vault-password
```

The playbooks handle things like:

* SSH setup & hardening
* Installing NGINX
* Installing PostgreSQL
* Installing Python and dependencies

---

## Cloud config (Hetzner API)

To automate more (like firewall setup), you’ll need an API token.

1. Generate a Hetzner API token in the Hetzner Cloud dashboard.
2. Encrypt it with Ansible Vault.
3. Run the playbook on your local machine to configure firewall and other cloud resources.


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

