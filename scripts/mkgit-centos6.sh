#!/usr/bin/env bash
# Install the latest version of git on CentOS 6.x
 
# Install Required Packages
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel wget
yum install  gcc perl-ExtUtils-MakeMaker
 
# Uninstall old Git RPM
yum remove git
 
# Download and Compile Git Source
cd /usr/src
wget https://www.kernel.org/pub/software/scm/git/git-2.4.4.tar.gz
tar xzf git-2.4.4.tar.gz 
 
cd git-2.4.4
make prefix=/usr/local/git all
make prefix=/usr/local/git install
 
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
ln -s /usr/local/git/bin/git /usr/bin/git
source /etc/bashrc
 
# Check Git Version
git --version
