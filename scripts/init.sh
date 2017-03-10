#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

src_path="/opt/src"

info "Configure apt-get Sources List"
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
" > /etc/apt/sources.list
echo "Done!"

info "Update OS software"
apt-get update
echo "Done!"

mkdir -p $src_path