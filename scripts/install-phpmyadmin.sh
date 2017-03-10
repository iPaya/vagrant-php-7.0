#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

src_path="/opt/src/phpmyadmin"
phpmyadmin_file_url='https://files.phpmyadmin.net/phpMyAdmin/4.6.6/phpMyAdmin-4.6.6-all-languages.tar.gz'

info "Install PHPMyAdmin"
mkdir -p $src_path && \
  cd $src_path && \
  wget $phpmyadmin_file_url && \
  tar xf phpMyAdmin-4.6.6-all-languages.tar.gz && \
  ln -s $src_path/phpMyAdmin-4.6.6-all-languages/ /var/www/html/phpmyadmin

echo "Done!"