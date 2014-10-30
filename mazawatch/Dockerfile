# version 1.4-1
# docker-version 0.9.1
FROM        phusion/passenger-full
MAINTAINER  guruvan "guruvan@shastafareye.net"

# We use a bootstrap script to avoid having temporary cache files and build
# dependencies being committed and included into the docker image.
COPY        . /tmp/
RUN         chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh
VOLUME      ["/home/maza"]
VOLUME      ["/home/mazachain"]
#XPOSE      MAZAWATCH
#XPOSE      LIVE TEST
EXPOSE      3000 3001
#ENTRYPOINT  [""]
CMD         ["/sbin/my_init"]
