# Build LAMP stack
A simple way to build LAMP stack, including a WordPress installation on Debian/Ubuntu server. 

We use one playbook and inventory file without complicated file structure. ansible.cfg is used for deactivating host key checks and defining inventory file and ssh user. 

Not suitable for production systems as this file could become large and difficult to manage. Also, this was developed entirely for education purposes.

* **Local Set up with Vagrant**

\- Start the virtual machines:

`cd Vagrant/ && vagrant up`

`cp vagrant_rsa ~/.ssh/`

\- Deploy:

`ansible-playbook playbook.yaml`

\- test:
curl http://192.168.111.201

curl http://192.168.111.202

\- destroy virtual machines:

`vagrant destroy --force`

`rm ~/.ssh/vagrant_rsa`


* **Cloud setup**

The ansible play structure here is quite simple and no conditions are used.
So if you want to test this with Cloud solutions, you should:

\- replace the content of inventory file with the IPs of the containers

\- Repalce the user in ansible.cfg and define custom Private key.