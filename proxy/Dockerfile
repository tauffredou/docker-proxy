FROM ubuntu:trusty
RUN apt-get update && apt-get install -y squid
COPY squid.conf /etc/squid3/squid.conf
CMD /usr/sbin/squid3 -NCd1
