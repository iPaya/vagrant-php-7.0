#!/usr/bin/env bash

mysql_root_password="root"

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install and configure MySQL"
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password \"'$mysql_root_password'\"" && \
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password \"'$mysql_root_password'\"" && \
apt-get install -y mysql-server-5.6 && \
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
mysql -uroot -proot -e "grant all on *.* to root@'%' identified by '$mysql_root_password';"
echo "Done!"