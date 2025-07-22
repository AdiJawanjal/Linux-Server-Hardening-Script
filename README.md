# Linux-Server-Hardening-Script

This repository contains a Bash script to **automate the hardening of an Amazon Linux 2023 server**. The goal is to improve security by disabling insecure services, configuring firewalls, securing SSH, and enabling brute-force protection using Fail2Ban.
---

## 📁 Files

- `server-hardening-amazon.sh`: The main script to harden your Amazon Linux 2023 system.

---

## ⚙️ Features

✅ Updates the system using `dnf`  
✅ Disables root login via SSH  
✅ Disables password-based SSH login (key-only login)  
✅ Installs and configures `firewalld`  
✅ Allows only SSH through the firewall  
✅ Installs and enables `fail2ban` via EPEL  
✅ Removes insecure services like `telnet` and `xinetd` (if present)  
✅ Restarts `sshd` to apply changes

---

## 🧰 Requirements

- Amazon Linux 2023 EC2 instance (or compatible VM)
- `sudo` privileges
