# ansible-research

This repository contains:  
- Different approaches for implementing LAMP stack with an application deployed.
- Application related unit tests written with pytest.  

### Directory structure with short description

    ├── application-tests                 # Pytest application-related tests.
    ├── magento2-elasticsearch            # Magento + Elasticsearch. Separated on 2 servers.
    ├── prometheus-grafana-dockers        # Prometheus and Grafana setup with Grafana dashboard imported
    ├── wp-letsencrypt-certbot-dockers    # WP + Certbot + Nginx(reverse proxy) + MariaDB on dockers.

All main-level directories could be considered as a separate and independent project.
They contain a readme file with further details.