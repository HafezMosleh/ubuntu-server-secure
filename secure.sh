#!/bin/bash
if [ "$EUID" -ne 0 ]; then echo "Run as root"; exit; fi
apt-get update && apt-get upgrade -y
apt-get install -y ufw fail2ban
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
systemctl enable fail2ban
systemctl start fail2ban
echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" >> /etc/fstab
echo "✅ Done"