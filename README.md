# ansible-research

This repository contains different approaches for implementing LAMP stack with WordPress application deployed. The directories are starting with numbers, and these numbers represent the complexity of the tasks.  

Every project-directory has a readme file with description of the task.  

Below you can find short description of each directory.

    ├── 1-LAMP-one-playbook             # Simple ansible usage.
    ├── 2-LAMP-structured-configs       # Structured project with roles, handlers, vars.
    ├── 3-dockers-wp                    # Setup docker env and run WP app.
    ├── 4-dockers-wp-es-kibana-beats    # Monitoring node - ES, Kibana, Logstash. Webtier - WP on dockers.
    ├── 5-dockers-wp-le-nginx           # In progress, final refactoring.

To be easier for testing, I included everywhere a Vagrant file, in a directory named vagrant. In that dir, we can find ssh keys in order to achieve the required setup quickly.
