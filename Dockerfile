FROM ubuntu:16.04

LABEL maintainer="andrekosak@icloud.com"

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD asset/* /opt/

RUN apt-get -q update && apt-get install -qy unzip \
    supervisor \
    xmlstarlet \
    vim \
    wget \
    default-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN wget --no-check-certificate \
      https://install.service-now.com/glide/distribution/builds/package/mid/2019/01/18/mid.london-06-27-2018__patch5-01-03-2019_01-18-2019_0328.linux.x86-64.zip \
      -O /tmp/mid.zip && \
    unzip -d /opt /tmp/mid.zip && \
    mv /opt/agent/config.xml /opt/ && \
    chmod 755 /opt/init && \
    chmod 755 /opt/fill-config-parameter && \
    rm -rf /tmp/*

EXPOSE 80 443

ENTRYPOINT ["/opt/init"]

CMD ["mid:start"]