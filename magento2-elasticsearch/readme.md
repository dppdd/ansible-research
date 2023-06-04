# Complete deploy of Magento 2.4 application

Ansible automation for bootstrapping Magento 2.4+ application.

## Requirements  
- [localhost] : Python3.9+, Ansible 2.14.*
- [lampserver] : CentOS 9 Stream
- [elasticserver] : Ubuntu 22.04 

---

### Usage: Manual Run  
- First add your hostnames or IPs into the `inventory` file. The file is also responsible for SSH configuration(port, flags). Remove the unused directives.
- Create a file named `.env-keys.yml` with the following content, and define the API keys issued by Adobe:

    adobe_user: 
    adobe_pass:

- Execute Ansible playbooks `ansible-playbook -i inventory site.yml`

### Usage: Automatic Run  
The `./ansible-init.sh` bash script can be used for easier configuration. The script will ask for the following information:  
```sh
IP of Magento server(LAMP + Magento)
IP of Elasticsearch server
Adobe username
Adobe password
```
For more info about how to generate Adobe keys, please check [here](https://experienceleague.adobe.com/docs/commerce-operations/installation-guide/prerequisites/authentication-keys.html).
Then you should execute
`ansible-playbook -i inventory site.yml`

---
## TODOs
- Despite the firewall mod to allow only the Magento node to access Elasticsearch, it is a good idea to have an actual Elasticsearch authentication - credentials or key.
- Add SSL support and automate domain management - it worth migrating to dockers for this step.
- Make tests so the repo could be maintained.
