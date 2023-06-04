# ansible-research

This repository contains different approaches for implementing LAMP stack with WordPress application deployed. The directories are starting with numbers, and these numbers represent the complexity of the tasks.  

Below you can find short description of each directory.

    ├── magento2-elasticsearch            # Magento + Elasticsearch. Separated on 2 servers.
    ├── prometheus-grafana-dockers        # Structured project with roles, handlers, vars.
    ├── wp-es-kibana-dockers              # Monitoring node - ES, Kibana, Logstash. Webtier - WP on dockers.
    ├── wp-lamp                           # WordPress on LAMP, Debian & Redhat
    ├── wp-letsencrypt-certbot-dockers    # WP + Certbot + Nginx(reverse proxy) + MariaDB on dockers.

Every project-directory has a readme file with description of the task.