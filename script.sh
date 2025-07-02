#!/bin/bash
# server-hardening.sh

echo "Starting Linux Server Hardening..."

# Update system
apt update && apt upgrade -y

# Disable root SSH login
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password authentication (use keys only)
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Set up firewall (UFW)
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Install Fail2Ban
apt install fail2ban -y
systemctl enable fail2ban
systemctl start fail2ban

# Remove unused services
apt remove -y telnet xinetd

# Restart SSH
systemctl restart ssh

echo "Server hardening completed."
