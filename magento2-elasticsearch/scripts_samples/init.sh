#!/bin/bash
### Init script for configuring CentOs 9 Stream basic security.
### Change SSH port to 9292, authorize SSH key and setup firewall

##### Important: Add SSH Public key below:
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo "public_key_here" > /root/.ssh/authorized_keys

echo "#### SSH Configuration ####"

# SSH configuration: Change port 22, to 9292 # Disabled Password auth
echo "Port 9292" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config


####### RedHAD Start #######
# Allow ports
yum install -y policycoreutils-python-utils
semanage port -a -t ssh_port_t -p tcp 9292
semanage port -m -t ssh_port_t -p tcp 9292
firewall-cmd --add-port=9292/tcp --permanent
firewall-cmd --reload

# For Elasticsearch
firewall-cmd --add-port=9200/tcp --permanent

####### RedHAD END #######

# Restart SSHD
systemctl restart sshd