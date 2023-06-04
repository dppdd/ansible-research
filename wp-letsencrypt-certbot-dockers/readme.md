# WordPress with Nginx and Let's Encrypt

A simple way with Ansible, to automate deployment of WordPress application on docker. The HTTP requests are handled by Nginx as a reverse proxy. Along with that a Certbot is deployed in order to issue a Let's Encrypt certificate. Everything runs on docker containers.  

## How to use

Currently, only CentOs playbook is developed. Once you set up the server, you should perform the following steps.

1. Open `./ansible.cfg` and define the remote ssh user and ssh port if not 22 is used.  

1. Add the IP(s) of the server in `./inventory`.

1. Define the production domain and email address for Certbot and Nginx in:  

```sh
./roles/docker-containers/vars:
production_domain
production_email
```

1. Test the connection
`ansible all -m ping`

1. Execute the configuration  
```sh
ansible-playbook site.yml
```

## In-depth description of the project

The automation workflow is as follows.  
- playbook-localhost.yml - Localhost environment is preparated.
- playbook-security.yml - Allow ports on the servers. Here we add all security-related tasks in regards to the node.  
- playbook-docker-env.yml - Prepare the docker environment, install all oficially advised services.  
- playbook-containers.yml - Deploy all required docker images. We will check this playbook's roles in detail below.

### playbook-containers.yml

The role for this playbook is roles/**docker-containers**. It is composed by the following mini-roles:

    ├── cronjob-certbot.yml
    ├── directories.yml
    ├── docker-certbot.yml
    ├── docker-mariadb.yml
    ├── docker-network.yml
    ├── docker-nginx-reverse.yml
    ├── docker-wordpress.yml
    └── self-signed-ssl.yml

Find a description of each one below. They are listed in the order of execution.

- directories.yml  
We create all required directories here and upload the custom nginx.conf to the server. It will be mounted to the nginx docker.

- docker-network.yml  
Set up the docker network.

- docker-mariadb.yml  
Create and start MariaDB container using the official docker image. Linkded to the wordpress container.

- docker-wordpress.yml  
Create and start WordPress docker container. Linkded to the mariadb container. Expose port 8080.

- self-signed-ssl.yml
We check if LE SSL is **not** deployed, and if **true**, a self-signed SSL is generated. This is done in order to have an existing SSL certificate for starting the Nginx service on separate docker. We avoid diving in more complex situation that way.

- docker-nginx-reverse.yml  
Create and start the Nginx docker. It is used as reverse proxy(80,443 proxied to 8080). Mount points: Nginx conf, Certboot docroot, SSL certificates

- docker-certbot.yml  
If no LE certificate found, create and run Certbot container with force-renewal command. With this condition we avoid force-renewing the SSL in every playbook execution.

- cronjob-certbot.yml  
We set up two commands as Cron Job. As advised by the Certbot documentation, one cron for running certbot container with renew command on every 12 hours. And one command for reloading nginx on every 6 hours.

## Final thoughts

This is a sample demo project. There are a lot of things that should be extended if you would like to host a well protected wordpress application. Consider addressing the below listed points if you want to go production. 

- Force HTTPS in nginx conf.
- Handle on/after server reboot.
- Increase security 
  - create some sudoer and redistribute the tasks
  - dissallow proxy bypassing by blocking port 8080 for public
  - Separate the web-server from wordpress container and add firewall
- Improve the volumes/mounts handing in containers
- Improve logging
- Add monitoring
- Add tests  

Feel free to contribute to this project!