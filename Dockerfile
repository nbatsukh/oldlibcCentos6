FROM centos:centos6

WORKDIR /install

# RUBY
RUN mkdir -p /opt/ruby-2.2.3/ && \
    curl -sSL https://s3.amazonaws.com/pkgr-buildpack-ruby/current/centos-6/ruby-2.2.3.tgz | tar xzC /opt/ruby-2.2.3/
RUN ln -s /opt/ruby-2.2.3 /opt/ruby

ENV PATH /opt/ruby/bin:${PATH}

RUN gem install os test-unit --no-ri --no-rdoc && \
    gem update --system --no-ri --no-rdoc

# SSH & golang & git
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN mkdir -p /go && yum install -y openssh-server openssh-clients golang
RUN yum -y groupinstall "Development Tools"

ENV GOROOT="/usr/lib/golang" GOPATH="/go" PATH="${PATH}:${GOPATH}"

COPY scripts/mkgit-centos6.sh .
RUN sh mkgit-centos6.sh

#seems -A option is illegal for CentOS. The key generation is handled by the server itself.
#generation of new keys is achieved by removing the old keys from /etc/ssh
RUN service sshd start

#ENTRYPOINT service sshd start && tail -f /dev/null
