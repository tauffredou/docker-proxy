FROM ubuntu:trusty
RUN apt-get update && apt-get install -y bind9

EXPOSE 53

CMD /usr/sbin/named -g
