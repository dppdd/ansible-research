# Build LAMP stack
A simple way to build LAMP stack, including a WordPress installation on Debian/Ubuntu server. 

We use one playbook and inventory file without complicated file structure. Not suitable for production systems as this file could become large and difficult to manage. 

* **Local Set up with Vagrant**

\- start the virtual machines:

`cd Vagrant/ && vagrant up`

\- deploy:

`cd .. && ansible -i inventory playbook.yaml`

\- test:
http://192.168.111.201

http://192.168.111.202

\- destroy virtual machines:

`vagrant destroy --force`


* **Cloud setup**

The ansible play structure here is quite simple and no conditions are used.
So if you want to test this with Cloud solutions, you should:

\- replace the content of inventory file with the IPs of the containers

\- Repalce the user for the connection in playbook.yaml, line 3