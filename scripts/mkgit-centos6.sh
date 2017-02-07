#!/usr/bin/env bash
# Install the latest version of git on CentOS 6.x
 
# Install Required Packages
yum install dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X && \
ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

curl -sSL https://www.kernel.org/pub/software/scm/git/git-1.9.1.tar.gz | tar xz

cd git-1.9.1 && \
make configure && \
./configure  --prefix=/usr/local && \
make all doc info && \
make install install-doc install-html install-info 

# Check Git Version
git --version
