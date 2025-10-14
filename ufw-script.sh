#!/usr/bin/env zsh

sudo ufw reset
sudo ufw enable

# ===============================
#  UFW CONFIGURATION FOR LOCAL SERVICES + LIBVIRT 
# ===============================

# ──────────────────────────────
# Akses SSH dari LAN
# ──────────────────────────────
sudo ufw allow in proto tcp from 192.168.0.0/24 to any port 22 comment 'Allow SSH from LAN'
#sudo ufw allow in proto tcp on virbr0 to any port 22 comment 'Allow SSH from VMs'

# ──────────────────────────────
# Web Server dan HTTPS
# ──────────────────────────────
sudo ufw allow in proto tcp from 192.168.0.0/24 to any port 80,443,8080 comment 'Allow HTTP/HTTPS access from LAN'

# ──────────────────────────────
# Perkhidmatan Kerberos
# ──────────────────────────────
sudo ufw allow in proto tcp from 192.168.0.0/24 to any port 88,464,749 comment 'Kerberos TCP (KDC, Admin, Change Password)'
sudo ufw allow in proto udp from 192.168.0.0/24 to any port 88,464 comment 'Kerberos UDP (KDC + kpasswd)'
sudo ufw allow in proto tcp from 192.168.122.0/24 to any port 88,464,749 comment 'Kerberos TCP for VMs'
sudo ufw allow in proto udp from 192.168.122.0/24 to any port 88,464 comment 'Kerberos UDP for VMs'

# ──────────────────────────────
# Servis Web/Database Dalaman
# ──────────────────────────────
sudo ufw allow in proto tcp from 192.168.0.0/24 to any port 3306,4443,8020,30033 comment 'Allow MariaDB, Flask, Hadoop, TeamSpeak'
sudo ufw allow in proto udp from 192.168.0.0/24 to any port 9987 comment 'Allow TeamSpeak Voice'

# ──────────────────────────────
# Multicast/mDNS (Local Discovery)
# ──────────────────────────────
sudo ufw allow in proto udp to 224.0.0.251 port 5353 comment 'Allow mDNS (Avahi, CUPS, SANE)'
sudo ufw allow out proto udp to 224.0.0.251 port 5353 comment 'Allow outgoing mDNS'

# ──────────────────────────────
# NFS (untuk perkongsian fail)
# ──────────────────────────────
sudo ufw allow in proto tcp from 192.168.0.0/24 to any port 2049 comment 'Allow NFS file sharing'

# ──────────────────────────────
# TAP Interfaces (untuk bridge atau VM spesifik)
# ──────────────────────────────
sudo ufw allow in on tap0 comment 'Allow bridge tap0 traffic'
sudo ufw allow out on tap0 comment 'Allow bridge tap0 traffic'
sudo ufw allow in on tap1 comment 'Allow bridge tap1 traffic'
sudo ufw allow out on tap1 comment 'Allow bridge tap1 traffic'
sudo ufw allow in on tap2 comment 'Allow bridge tap2 traffic'
sudo ufw allow out on tap2 comment 'Allow bridge tap2 traffic'

# ──────────────────────────────
# Benarkan komunikasi NAT libvirt (default: virbr0)
# ──────────────────────────────
sudo ufw allow in on virbr0 comment 'Allow inbound NAT traffic from VMs'
sudo ufw allow out on virbr0 comment 'Allow outbound NAT traffic to VMs'

# ──────────────────────────────
# DHCP/DNS untuk NAT (pilihan, jika peraturan virbr0 tidak cukup)
# ──────────────────────────────
# sudo ufw allow in proto udp from 192.168.122.0/24 to any port 53,67 comment 'Optional: Allow DHCP/DNS for libvirt NAT'

# ──────────────────────────────
# Aktifkan semula UFW
# ──────────────────────────────
sudo ufw reload
sudo ufw status verbose
