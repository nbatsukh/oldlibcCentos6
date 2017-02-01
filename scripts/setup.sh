#!/usr/bin/env sh

setup_go(){
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum install -y golang
}

setup_tools(){
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    echo 'export rvm_prefix="$HOME"' > /root/.rvmrc
    echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmrc
    curl -sSL https://get.rvm.io | rvm_path=/root/.rvm bash -s stable --ruby=2.3.1 --with-gems="rake,os,test-unit"
    cat /root/.rvmrc
    /bin/bash --login -c  'rvm list && rvm --default use 2.3.1'
}

setup_ssh() {
    yum install -y openssh-server
    yum install -y openssh-clients
    # seems -A option is illegal for CentOS. The key generation is handled by the server itself.
    # generation of new keys is achieved by removing the old keys from /etc/ssh
    ## ssh-keygen -A
    echo "Before..."
    ls -1 /etc/ssh
    echo "============"
    service sshd start
    echo "After..."
    ls -1 /etc/ssh
    echo "==========="
}

case "$1" in
  go)
    setup_go
    ;;
  tools)
    setup_tools
    ;;
  ssh)
    setup_ssh
    ;;
  *)
    echo "Usage: ${basename} {go|tools|ssh}" || true
    exit 1
esac

exit 0
