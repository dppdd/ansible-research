# Deploy and configure LAMP stack
A simple way to build LAMP stack, including a WordPress installation on Debian based server.  

We use one playbook and inventory file without complicated file structure.   

ansible.cfg is used for deactivating host key checks and defining inventory file and ssh user.

* **Local Set up with Vagrant**

1. Start the virtual machines:  

    cd Vagrant/ && vagrant up  

    cp vagrant_rsa ~/.ssh/

2. Deploy:  

    ansible-playbook playbook.yaml

3. Verify:  

    curl http://192.168.111.201
    curl http://192.168.111.202

4. Destroy virtual machines:  

    vagrant destroy --force
    rm ~/.ssh/vagrant_rsa


* **Cloud setup**

1. Replace the content of inventory file with the IPs of the containers.  

2. Replace the user in ansible.cfg and define custom Private key.