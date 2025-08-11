#!/bin/bash
# server-hardening-ubuntu.sh
echo "🔒 Starting Linux Server Hardening on Ubuntu..."

# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

# Disable root SSH login
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password-based SSH login (enable key-only)
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Install ufw (Uncomplicated Firewall) if not present
if ! command -v ufw &> /dev/null; then
    sudo apt-get install -y ufw
fi

# Configure firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

# Install fail2ban
sudo apt-get install -y fail2ban

# Enable and start fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Remove insecure packages (if installed)
sudo apt-get remove -y telnetd telnet || true

# Restart SSH daemon
sudo systemctl restart sshd

echo "✅ Server hardening completed successfully on Ubuntu."
