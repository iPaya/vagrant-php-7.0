#!/usr/bin/env bash

src_path="/opt/src"
php_version="7.0.12"
php_src_path="$src_path/php/"
php_path="/opt/php/php-$php_version"
php_ext_path="/etc/php7"
swoole_src_path="$src_path/swoole"
yaconf_src_path="$src_path/yaconf"

#== Bash helpers ==
function info {
  echo " "
  echo "--> $1"
  echo " "
}

info "Install additional software"
apt-get install -y libxml2-dev libcurl4-gnutls-dev libjpeg-dev libpng12-dev libfreetype6-dev libgmp-dev libc-client2007e-dev libicu-dev \
  libmcrypt-dev libpspell-dev libreadline-dev libtidy-dev libxslt1-dev

info "Done!"

info "Install and config PHP7"
ln -s /usr/lib/x86_64-linux-gnu/libssl.so  /usr/lib  && \
ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
mkdir -p "$php_path" "$php_ext_path" "$php_ext_path/conf.d" "$php_src_path" && \
cd "$php_src_path" && \
wget "http://cn2.php.net/distributions/php-$php_version.tar.gz" && \
tar xzf "php-$php_version.tar.gz" && \
cd "php-$php_version" && \
./configure --prefix="$php_path" \
  --with-apxs2=/usr/bin/apxs2  \
  --enable-zend-signals  \
  --with-gd  \
  --with-jpeg-dir=/usr  \
  --with-png-dir=/usr  \
  --with-freetype-dir=/usr  \
  --enable-gd-native-ttf  \
  --enable-exif  \
  --with-config-file-path="$php_ext_path"  \
  --with-config-file-scan-dir="$php_ext_path/conf.d"  \
  --with-mysql-sock=/var/run/mysqld/mysqld.sock  \
  --with-zlib  \
  --enable-phpdbg  \
  --with-gmp  \
  --with-zlib-dir=/usr  \
  --with-gettext  \
  --with-kerberos  \
  --with-imap-ssl  \
  --with-mcrypt=/usr/local  \
  --with-iconv  \
  --enable-sockets  \
  --with-openssl  \
  --with-pspell  \
  --with-pdo-mysql=mysqlnd  \
  --with-pdo-sqlite  \
  --with-pgsql  \
  --with-pdo-pgsql  \
  --enable-soap  \
  --enable-xmlreader  \
  --enable-phar=shared  \
  --with-xsl  \
  --enable-ftp  \
  --enable-cgi  \
  --with-curl=/usr  \
  --with-tidy  \
  --with-xmlrpc  \
  --enable-mbstring  \
  --enable-sysvsem  \
  --enable-sysvshm  \
  --enable-shmop  \
  --with-readline  \
  --enable-pcntl  \
  --enable-fpm  \
  --enable-intl  \
  --enable-zip  \
  --with-imap  \
  --with-mysqli=mysqlnd  \
  --enable-calendar  \
  --enable-bcmath  \
  --enable-opcache-file && \
  make --quiet && make install
cp $php_src_path/php-${php_version}/php.ini-development $php_ext_path/php.ini

for FILE in $php_path/bin/*;do ln -s $FILE '/usr/local/bin/'`basename $FILE`;done
for FILE in $php_path/sbin/*;do ln -s $FILE '/usr/local/bin/'`basename $FILE`;done

echo "AddType application/x-httpd-php .php
AddType application/x-httpd-php .html
AddType application/x-httpd-php .php .phtml .php3 .php4
AddType application/x-httpd-php-source .phps
" > /etc/apache2/conf-available/php7.conf && \
ln -s /etc/apache2/conf-available/php7.conf /etc/apache2/conf-enabled/php7.conf
echo "; configuration for php common module
; priority=20
extension=phar.so
" > $php_ext_path/conf.d/20-phar.ini
echo "Done!"

info "Install PHP XDebug"
xdebug_src_path="$src_path/xdebug";
mkdir -p $xdebug_src_path && \
    cd $xdebug_src_path && \
    wget https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_1.tar.gz && \
    tar xzf XDEBUG_2_5_1.tar.gz && \
    cd xdebug-XDEBUG_2_5_1 && \
    phpize && \
    ./configure --enable-xdebug && \
    make --quiet && \
    make install && \
    echo -e "; configuration for XDebug module
; priority=20
extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.idekey=\"XDEBUG\"
" > "$php_ext_path/conf.d/20-xdebug.ini"
echo "Done!"

info "Enable phpinfo in http://localhost/phpinfo.php"
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
echo "Done!"