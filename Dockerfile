FROM centos:centos6

ENV APP_HOME /code
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY scripts/setup.sh .
RUN sh ./setup.sh tools
RUN sh ./setup.sh go
RUN sh ./setup.sh ssh

