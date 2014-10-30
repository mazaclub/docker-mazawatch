#
USER=mazaclub
PROJECT=mazabase
docker run -d -v /home/maza --name="${PROJECT}_mazablocks" ${USER}/${PROJECT}-mazablocks:latest
