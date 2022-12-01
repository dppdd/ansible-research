# Build LAMP stack  
using the best practices outlined in ansible docs

Here we continue the ansible research and tests, using a bit more complex file structure. Below you can find the used structure.


    ├── ansible.cfg                    # Define SSH user, key and disable host key verification 
    ├── lampservers.yml                # Define roles for LAMP servers
    ├── production                     # Place IPs/hostnames of production machines
    ├── readme.md
    ├── roles                          # Here we place roles' files
    │   ├── common
    │   │   ├── handlers
    │   │   └── tasks
    │   │       ├── debian.yml         # Tasks for Debian OS
    │   │       ├── main.yml           # Check OS and load the respective playbook
    │   │       └── redhat.yml         # Tasks for CentOs OS
    │   └── webtier
    │       ├── handlers
    │       ├── tasks
    │       │   ├── debian.yml
    │       │   ├── main.yml
    │       │   └── redhat.yml
    │       └── vars
    │           └── main.yml           # Variables for webtier role
    ├── site.yml                       # Main ansible gateway
    ├── staging                        # Place IPs/hostnames of staging machines
    └── vagrant                        # Directory containing Vagrant Boxes configs.
        ├── Vagrantfile                # Main vagrant file
        ├── provisioning-script.sh     # Provisioning script for each vagrant box
        └── vagrant_rsa                # Private key that you can use for the connection.

**Run ansible playbooks:**

    ansible-playbook -i staging site.yml

    ansible-playbook -i production site.yml