FROM andrekosak/docker-armhf-ubuntu:xenial
LABEL maintainer="andrekosak@icloud.com"

RUN [ "cross-build-start" ]

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD asset/* /opt/

RUN apt-get -q update && apt-get install -qy unzip \
    supervisor \
    xmlstarlet \
    vim \
    openjdk-8-jre-headless \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN wget --no-check-certificate \
      https://install.service-now.com/glide/distribution/builds/package/mid/2018/07/14/mid.london-06-27-2018__patch0-07-11-2018_07-14-2018_1223.linux.x86-32.zip \
      -O /tmp/mid.zip && \
    unzip -d /opt /tmp/mid.zip && \
    mv /opt/agent/config.xml /opt/ && \
    chmod 755 /opt/init && \
    chmod 755 /opt/fill-config-parameter && \
    rm -rf /opt/agent/jre && \
    echo "wrapper.java.command=/usr/lib/jvm/java-1.8.0-openjdk-armhf/jre/bin/java" >> /opt/agent/conf/wrapper-override.conf && \
    echo "wrapper.java.maxmemory=256" >> /opt/agent/conf/wrapper-override.conf && \
    echo "set.SNC_JVM_ARCH=arm" >> /opt/agent/conf/wrapper-jvm.conf && \
    ln -s -r /opt/agent/bin/wrapper-linux-armhf-32 /opt/agent/bin/wrapper-linux-armv7l-32 && \
    rm -rf /tmp/*

RUN [ "cross-build-end" ]

EXPOSE 80 443
ENTRYPOINT ["/opt/init"]
CMD ["mid:start"]