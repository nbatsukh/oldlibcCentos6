FROM centos:centos6

ENV APP_HOME /code
ENV GOROOT   /usr/lib/golang
ENV GOPATH   /go

COPY scripts/setup.sh .
RUN sh ./setup.sh tools
RUN sh ./setup.sh go
RUN sh ./setup.sh ssh

