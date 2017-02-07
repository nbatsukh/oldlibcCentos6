#!/usr/bin/env bash
# Install the latest version of git on CentOS 6.x
 
# Install Required Packages
yum -y install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel

curl -sSL https://www.kernel.org/pub/software/scm/git/git-1.9.1.tar.gz | tar xz

cd git-1.9.1 && make configure && ./configure  --prefix=/usr/local && \
   make all &&  make install
cd .. 
# Check Git Version
git --version
