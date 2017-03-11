#!/usr/bin/env bash

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Clean"

# 删除无用的依赖包
apt-get autoremove -y

# 清理下载的软件包
apt-get clean -y

# 删除 PHP 源码
rm -rf /opt/src/php/

# 删除临时文件
rm -rf /tmp/*

# 删除 PHPMyAdmin 下载包
rm -f /opt/src/phpmyadmin/phpMyAdmin-4.6.6-all-languages.tar.gz

info "Done!"