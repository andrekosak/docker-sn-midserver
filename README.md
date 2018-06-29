# Get started

docker run -d --name sn-mid-server \
  -e 'SN_URL=dev00000.service-now.com' \
  -e 'SN_USER=admin' \
  -e 'SN_PASSWD=admin' \
  -e 'SN_MID_NAME=sn-mid-server' \
  andrekosak/docker-sn-midserver