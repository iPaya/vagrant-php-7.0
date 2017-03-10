#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install and configure apache2"
apt-get install -y apache2 apache2-utils apache2-dev apache2-mpm-prefork && \
echo -e "ServerName localhost\n" >> "/etc/apache2/apache2.conf" && \
a2dismod mpm_event && \
a2enmod mpm_prefork
echo "Done!"