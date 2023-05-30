# Complete deploy of Magento 2.4 application

Ansible automation for bootstrapping Magento 2.4+ application.

## Requirements  
- [localhost] : Python3.9+, Ansible 2.14.*
- [lampserver] : CentOS 9 Stream
- [elasticserver] : Ubuntu 22.04 

## How to use
The `./ansible-init.sh` bash script can be used for easier configuration. The script will ask for the following information:  
```sh
IP of Magento server(LAMP + Magento)
IP of Elasticsearch server
Adobe username
Adobe password
```
For more info about how to generate Adobe keys, please check [here](https://experienceleague.adobe.com/docs/commerce-operations/installation-guide/prerequisites/authentication-keys.html).
Then you should execute
```sh
ansible-playbook -i inventory site.yml
```

## In-depth description of the project
