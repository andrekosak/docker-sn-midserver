[![License MIT](https://img.shields.io/badge/license-ISC-blue.svg)](https://opensource.org/licenses/ISC) [![](https://ga-beacon.appspot.com/UA-82522402-3/readme?pixel)](https://github.com/igrigorik/ga-beacon)

# What is ServiceNow Mid Sever 

[Read here](https://docs.servicenow.com/bundle/kingston-servicenow-platform/page/product/mid-server/reference/r-MIDServer.html)

Why do you need it? Just ignore this repo if you don't know the answer.

# TL;DR;

```bash
$ docker run -d --name sn-mid-server \
  -e 'SN_URL=dev00000.service-now.com' \
  -e 'SN_USER=username' \
  -e 'SN_PASSWD=userpassword' \
  -e 'SN_MID_NAME=sn-mid-server' \
  andrekosak/docker-sn-midserver
```

or using Docker Compose:

```yaml
version: '3'
services:
  midserver:
    container_name: sn-midserver
    image: docker-sn-midserver:latest
    network_mode: host
    environment:
      - SN_URL=dev00000.service-now.com
      - SN_USER=username
      - SN_PASSWD=password
      - SN_MID_NAME=my-mid-server
```

# Persisting config and logs

```bash
$ docker run -d --name sn-mid-server \
  -e 'SN_URL=dev00000.service-now.com' \
  -e 'SN_USER=username' \
  -e 'SN_PASSWD=password' \
  -e 'SN_MID_NAME=my-mid-server' \
  -v './sn-midserver/logs:/opt/agent/logs' \
  -v './sn-midserver/config.xml:/opt/agent/config.xml' \
  andrekosak/docker-sn-midserver
```

or using Docker Compose:

```yaml
version: '3'
services:
  midserver:
    container_name: sn-midserver
    image: docker-sn-midserver:latest
    volumes:
      - ./sn-midserver/logs:/opt/agent/logs
      - ./sn-midserver/config.xml:/opt/agent/config.xml
    network_mode: host
    environment:
      - SN_URL=dev00000.service-now.com
      - SN_USER=username
      - SN_PASSWD=password
      - SN_MID_NAME=my-mid-server
```