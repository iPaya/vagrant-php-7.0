# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'fileutils'

config = {
  vagrant: './config/vagrant.yml',
  example: './config/vagrant.example.yml'
}

# copy config from example if local config not exists
FileUtils.cp config[:example], config[:vagrant] unless File.exist?(config[:vagrant])

# read config
options = YAML.load_file config[:vagrant]

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |vb|
	# machine cpus count
    vb.cpus = options["cpus"]
    # machine memory size
    vb.memory = options["memory"]
  end

  config.vm.provision 'shell', path: './scripts/init.sh'
  config.vm.provision 'shell', path: './scripts/install-basic.sh'
  config.vm.provision 'shell', path: './scripts/install-supervisor.sh'
  config.vm.provision 'shell', path: './scripts/install-mysql.sh'
  config.vm.provision 'shell', path: './scripts/install-apache.sh'
  config.vm.provision 'shell', path: './scripts/install-php.sh'
  config.vm.provision 'shell', path: './scripts/install-redis.sh'
  config.vm.provision 'shell', path: './scripts/install-phpmyadmin.sh'

  config.push.define "atlas" do |push|
    push.app = "iPaya/php-7.0"
  end

  # post-install message (vagrant console)
  config.vm.post_up_message = "Congratulations!!!\n"
end