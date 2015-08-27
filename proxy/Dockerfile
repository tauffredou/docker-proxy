FROM ubuntu:trusty
RUN apt-get update && apt-get install -y iptables devscripts build-essential fakeroot libssl-dev ssl-cert squid-langpack
RUN apt-get source -y squid
RUN apt-get build-dep -y squid
RUN dpkg-source -x squid3_*.dsc
COPY rules.patch rules.patch
RUN patch squid3-*/debian/rules < rules.patch
RUN cd squid3-* && dpkg-buildpackage -rfakeroot -b

RUN dpkg --install squid3-common_*_all.deb \
    && dpkg --install squid3_*_amd64.deb \
    && dpkg --install squidclient_*_amd64.deb

COPY squid.conf /etc/squid3/squid.conf
COPY wrapper.sh /wrapper.sh
COPY myca.pem /etc/squid3/myca.pem
RUN chmod +x /wrapper.sh
CMD /wrapper.sh
