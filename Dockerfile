FROM centos:centos6

ENV APP_HOME /code

# RUBY
RUN mkdir -p /opt/ruby-2.2.3/ && \
    curl -s https://s3.amazonaws.com/pkgr-buildpack-ruby/current/centos-6/ruby-2.2.3.tgz | tar xzC /opt/ruby-2.2.3/

ENV PATH /opt/ruby-2.2.3/bin:${PATH}

RUN gem install rake os test-unit --no-ri --no-rdoc
RUN gem update --system --no-ri --no-rdoc

# GO
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum install -y golang

ENV GOROOT   /usr/lib/golang
ENV GOPATH   /go
ENV PATH ${PATH}:${GOPATH}

RUN go get gopkg.in/hypersleep/easyssh.v0

# SSH
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
#seems -A option is illegal for CentOS. The key generation is handled by the server itself.
#generation of new keys is achieved by removing the old keys from /etc/ssh
RUN service sshd start

