#!/bin/bash

###TODO: add final interaction option for executing the ansible automation.

# Check arguments
case "$1" in

# Clear hosts file
-c) rm .env-keys.yml && cp scripts_samples/.env-keys.yml-sample .env-keys.yml
    rm inventory && cp scripts_samples/inventory-sample inventory
    exit 0
    ;;
esac


cat <<EOF
    Hello dear user,
    This script aims to prepare the required inventory for the 
    ansible project. The requirements are:
        - IP of the node hosting elasticsearch service
        - IP of the node hosting the Magento app
        - User and Password for Magento repo.
    Please prepare those.
    Click any key to proceed.
EOF

read

echo "Define the IP of the server which will host the Magento application"
read mage_ip
echo
echo "Define the IP of the elasticsearch server"
read es_ip
echo 
echo "Define Adobe username"
read adobe_user
echo "Define Adobe password"
read adobe_pass

# Validate the passed arguments if they are actual IPs
if [[ ! $mage_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
    echo 'Incorrect IP: Magento Server'
    exit 0
fi
if [[ ! $es_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
    echo 'Incorrect IP: Elasticsearch Server'
    exit 0
fi

template_inventory=$(cat <<EOF
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_port=9292
ansible_user = root

[lampserver]
$mage_ip

[elasticserver]
$es_ip

EOF
)


template_mage_keys=$(cat <<EOF
---

adobe_user: $adobe_user
adobe_pass: $adobe_pass

EOF
)


echo "$template_inventory" > inventory
echo "$template_mage_keys" > .env-keys.yml


cat <<EOF


    If you defined an incorrect data, you can correct manually. Files edited are:

    inventory
    .env-keys.yml

    You can also reset the files by executing the ./ansible-init.sh -c. 

    Now you can run the following command to initiate the configuration and deploy!

    ansible-playbook -i inventory site.yml

    Enjoy!
EOF
