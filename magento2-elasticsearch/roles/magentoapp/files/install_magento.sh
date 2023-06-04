#!/bin/bash

cd /var/www/html && bin/magento setup:install \
--base-url=http://$1 \
--db-host=localhost \
--db-name=mage_db \
--db-user=mage_user \
--db-password=mage_pass \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123_! \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--search-engine=opensearch \
--opensearch-host=$2 \
--opensearch-port=9200 \
--opensearch-index-prefix=magento2 \
--opensearch-timeout=15

echo "Magento app alrady installed" > /root/ansible_helpers/installed/magento.txt

#TODO Allow htaccess

# Set permissions
chown -R apache. /var/www/html/
chcon -R --type httpd_sys_rw_content_t /var/www/html/app/etc
chcon -R --type httpd_sys_rw_content_t /var/www/html/var
chcon -R --type httpd_sys_rw_content_t /var/www/html/pub/media
chcon -R --type httpd_sys_rw_content_t /var/www/html/pub/static

# Compile Magento
bin/magento setup:di:compile

# Fix permissions. Usually the var dir is changed upon compile
chown -R apache. /var/www/html/




