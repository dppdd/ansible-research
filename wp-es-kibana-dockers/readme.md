# WordPress on dockers monitored by ElasticSearch

WordPress and MariaDB dockers running on nodes labaled as *containers.* Metricbeat is also installed and configured to send its metrics to monitoring server.

File Structure:  

    ├── ansible.cfg
    ├── inventory
    ├── playbook-containers.yml
    ├── playbook-localhost.yml
    ├── playbook-monitoring.yml
    ├── readme.md
    ├── roles
    │   ├── containers-init
    │   │   └── tasks
    │   │       ├── debian.yml
    │   │       ├── main.yml
    │   │       └── redhat.yml
    │   ├── containers-webtier
    │   │   ├── tasks
    │   │   │   ├── docker-mariadb.yml
    │   │   │   ├── docker-network.yml
    │   │   │   ├── docker-wordpress.yml
    │   │   │   ├── main.yml
    │   │   └── vars
    │   │       └── main.yml
    │   ├── localhost
    │   │   └── tasks
    │   │       └── main.yml
    │   ├── metrics
    │   │   ├── tasks
    │   │   │   └── main.yml
    │   │   └── vars
    │   │       └── main.yml
    │   └── monitoring-init
    │       ├── handlers
    │       │   └── main.yml
    │       ├── tasks
    │       │   ├── elasticsearch.yml
    │       │   ├── kibana.yml
    │       │   ├── logstash.yml
    │       │   └── main.yml
    │       ├── templates
    │       │   ├── beatsconf.j2
    │       │   ├── hostvar.j2
    │       │   └── jvm.options.j2
    │       └── vars
    │           └── main.yml
    ├── site.yml
    └── vagrant

Entry point:

    $ cat site.yml
    ---
    - import_playbook: playbook-localhost.yml
    - import_playbook: playbook-containers.yml
    - import_playbook: playbook-monitoring.yml

To run the configuration, execute:  

    ansible-playbook site.yml

If you used the provided vagrant boxes, access Kibana at http://192.168.111.202:5601, and WordPress applications directly via their node IPs, e.g.  http://192.168.111.201.