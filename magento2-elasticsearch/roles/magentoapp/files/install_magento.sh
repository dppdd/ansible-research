#!/bin/bash

# Set Variables
hostname_mage=$1
hostname_elasticsearch=$2
web_doc_root=$3
elasticsearch_port=$4
dbname=$5
dbuser=$6 
dbpass=$7
admin_user=$8
admin_pass=$9
ansible_helper_dir="${10}"
flag_file_magento="${11}"

cd $web_doc_root && bin/magento setup:install \
--base-url=http://$hostname_mage \
--db-host=localhost \
--db-name=$dbname \
--db-user=$dbuser \
--db-password=$dbpass \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=$admin_user \
--admin-password=$admin_pass \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--search-engine=opensearch \
--opensearch-host=$hostname_elasticsearch \
--opensearch-port=$elasticsearch_port \
--opensearch-index-prefix=magento2 \
--opensearch-timeout=15

# Leave a trace. 
# This is done so we can set condition in ansible:
# to execute this script only if the below file does not exist.
mkdir -p $ansible_helper_dir
echo "Magento app alrady installed" > "${ansible_helper_dir}/${flag_file_magento}"


# # Set permissions
chown -R apache. $web_doc_root/
chcon -R --type httpd_sys_rw_content_t $web_doc_root/app/etc
chcon -R --type httpd_sys_rw_content_t $web_doc_root/var
chcon -R --type httpd_sys_rw_content_t $web_doc_root/pub/media
chcon -R --type httpd_sys_rw_content_t $web_doc_root/pub/static

# # Compile Magento
bin/magento setup:di:compile

# # Fix permissions. Usually the var dir is changed upon compile
chown -R apache. $web_doc_root
