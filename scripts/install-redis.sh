#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install Redis"
apt-get install -y redis-server redis-tools && \
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf
echo "Done!"