#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install Supervisor"
apt-get install -y supervisor
info "Done!"