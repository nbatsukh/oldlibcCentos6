FROM centos:centos6

ENV APP_HOME /code

# RUBY
RUN mkdir -p /opt/ruby-2.2.3/ && \
    curl -s https://s3.amazonaws.com/pkgr-buildpack-ruby/current/centos-6/ruby-2.2.3.tgz | tar xzC /opt/ruby-2.2.3/
RUN ln -s /opt/ruby-2.2.3 /opt/ruby

# GO
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
yum install -y git golang

ENV GOROOT="/usr/lib/golang" GOPATH="/go" PATH="${PATH}:/opt/ruby/bin:${GOPATH}"

RUN gem install os test-unit --no-ri --no-rdoc && \
    gem update --system --no-ri --no-rdoc

# SSH
RUN yum install -y openssh-server openssh-clients
#seems -A option is illegal for CentOS. The key generation is handled by the server itself.
#generation of new keys is achieved by removing the old keys from /etc/ssh
RUN service sshd start
