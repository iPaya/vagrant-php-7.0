#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install Basic packages"
apt-get install -y build-essential autoconf ntp git zip unzip
info "Done"
