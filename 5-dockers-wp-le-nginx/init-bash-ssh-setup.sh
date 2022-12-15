#!/bin/bash
### Init script for configuring CentOs 9 Stream basic security.
### Change SSH port to 9292, authorize SSH key and setup firewall

##### Important: Add SSH Public key below:
echo "public_key_here" > ~/.ssh/authorized_keys

echo "#### SSH Configuration ####"

# SSH configuration: Change port 22, to 9292 # Disabled Password auth
echo "Port 9292" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Allow port
firewall-cmd --add-port=9292/tcp --permanent
firewall-cmd --reload

yum install -y policycoreutils-python-utils-3.3-5.el9
semanage port -a -t ssh_port_t -p tcp 9292
semanage port -m -t ssh_port_t -p tcp 9292
# ^^^ ?!

# Restart SSHD
systemctl restart sshd