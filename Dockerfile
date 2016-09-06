FROM ubuntu:14.04
MAINTAINER Monica Sarbu <monica@elastic.co>

ENV METRICBEAT_VERSION=5.0.0-alpha6-SNAPSHOT

RUN apt-get update
RUN apt-get -y -q install wget

RUN wget https://beats-nightlies.s3.amazonaws.com/metricbeat/metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz
RUN tar -xvvf metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz
RUN mv metricbeat-${METRICBEAT_VERSION}-linux-x86_64/ /etc/metricbeat
RUN mv /etc/metricbeat/metricbeat.yml /etc/metricbeat/metricbeat.example.yml
RUN mv /etc/metricbeat/metricbeat /bin/metricbeat

ADD bin/metricbeat /bin/

#RUN curl -L -O http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
#    mkdir -p /usr/share/GeoIP && \
#    gunzip -c GeoLiteCity.dat.gz > /usr/share/GeoIP/GeoLiteCity.dat

WORKDIR /metricbeat

ADD files/ .

CMD /metricbeat/start.sh
