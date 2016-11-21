FROM centos:6.8
MAINTAINER "Shen-You Chen <chenshenyou@gmail.com>"

ENV ORACLE_HOME=/usr/lib/oracle/11.2/client64

COPY instantclient/* /tmp/

RUN \
  yum -y update && \
  yum -y install libaio gcc && \
  yum -y install epel-release && \
  yum -y install python34 python34-devel python34-setuptools && \
  easy_install-3.4 pip && \
  rpm -ivh /tmp/oracle-instantclient*.rpm && \
  mkdir -p /usr/lib/oracle/11.2/client64/network/admin/ && \
  echo "/usr/lib/oracle/11.2/client64/lib" > /etc/ld.so.conf.d/oracle.conf && \
  ldconfig && \
  pip3 install cx_Oracle
