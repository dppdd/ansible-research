# WordPress dockers example

Simple example project of WordPress app running on docker containers.  
The file structure is similar to the previous one, outlined in ansible doc's best practices article.  

    .
    ├── ansible.cfg                         # Define SSH user, key and disable host key verification 
    ├── inventory
    ├── readme.md
    ├── roles
    │   ├── docker                          # docker services setup depending on the host OS.
    │   │   └── tasks
    │   │       ├── debian.yml
    │   │       ├── main.yml                # Condition OS and execute the respective configuration.
    │   │       └── redhat.yml
    │   └── wordpress                       # Docker container configurations.
    │       ├── tasks
    │       │   ├── main.yml               
    │       │   └── wp-mysql-deploy.yml     # Run docker containers here 
    │       └── vars
    │           └── main.yml
    ├── site.yml
    ├── vagrant                             # Vagrant boxes
    │   ├── Vagrantfile
    │   ├── provisioning-script.sh
    │   └── vagrant_rsa
    └── wpservers.yml                       # Define roles and servers for execution.

Entry point:  

    $ cat site.yml
    ---
    - import_playbook: wpservers.yml

Run with  

    ansible-playbook site.yml