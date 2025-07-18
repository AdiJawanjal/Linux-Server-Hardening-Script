#!/bin/bash
# server-hardening-amazon.sh

echo "🔒 Starting Linux Server Hardening on Amazon Linux 2023..."

# Update system
sudo dnf update -y

# Disable root SSH login
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password-based SSH login (enable key-only)
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Install firewalld if not present
if ! command -v firewall-cmd &> /dev/null; then
    sudo dnf install -y firewalld
    sudo systemctl enable firewalld
    sudo systemctl start firewalld
fi

# Configure firewall
sudo firewall-cmd --permanent --set-default-zone=public
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# Install fail2ban (from EPEL)
sudo dnf install -y epel-release
sudo dnf install -y fail2ban

# Enable and start fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Remove insecure packages (if installed)
sudo dnf remove -y telnet xinetd || true

# Restart SSH daemon
sudo systemctl restart sshd

echo "✅ Server hardening completed successfully on Amazon Linux 2023."
