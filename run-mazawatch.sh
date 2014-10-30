#!/bin/bash
USER=mazaclub
PROJECT=mazabase
DAEMON=${USER}/mazacoin-new
BLOCKS=${USER}/mazablocks:empty
WALLET=${USER}/mazawallets
LDB=${USER}/mazawatch-ldb
EXPLORER=${USER}/mazawatch
EXPLORERIMG=${USER}/mazawatch
P2P_OUTSIDE=12835
P2P_INSIDE=12835
MZCRPC=12832
MW_INSIDE=3000
MW_OUTSIDE=3000
NGINX_OUTSIDE=34552
NGINX_INSIDE=80

docker images |awk '{print $1":"$2}' |grep ${BLOCKS} || docker pull ${BLOCKS} 
docker images |awk '{print $1":"$2}' |grep ${DAEMON} || docker pull ${DAEMON}
docker images |awk '{print $1":"$2}' |grep ${WALLET} || docker pull ${WALLET}

if [ "${1}" = "-testnet" ] ; then
  PROJECT=testnet
fi

if [ "${PROJECT}" = "testnet" ] ; then
   BLOCKS="${USER}/${PROJECT}-mazablocks:empty"
   LDB=${USER}/${PROJECT}-mazawatch-ldb
   P2P_OUTSIDE=11835
   P2P_INSIDE=11835
   MZCRPC=11832
   MW_INSIDE=3001
   MW_OUTSIDE=3001
fi   
avail=`docker images |awk '{print $1":"$2}' |grep ${DAEMON}`
if [ "${avail}X" = "X" ] ; then
   git clone https://github.com/mazaclub/docker-mazacoin-new
   cd docker mazacoin-new
   sed -i 's/PROJECT\=.*/PROJECT\='${PROJECT}'/g' run-mazacoin-prebuilt.sh
   make all
fi
mwavail=`docker images |awk '{print $1":"$2}' |grep ${EXPLORER}`
echo "${mwavail}"

if [ "${mwavail}X" = "X" ] ;then
   docker pull ${EXPLORERIMG}
   docker images |awk '{print $1":"$2}' |grep ${EXPLORER} || docker tag ${EXPLORERIMG}  ${EXPLORER}
fi

echo "`date` Starting ${PROJECT}_mazablocks"
mb=`docker ps -a|awk '{print $NF}'  |grep ${PROJECT}_mazablocks`
if [ "${mb}" != "${PROJECT}_mazablocks" ] ; then   
   echo "`date` mazablocks not running. Starting..." && docker run -d -v /home/maza --name="${PROJECT}_mazablocks" ${BLOCKS}
fi
echo "`date` Starting ${PROJECT}_mazawallets"
mb=`docker ps -a|awk '{print $NF}' |grep ${PROJECT}_mazawallets`
if [ "${mb}" != "${PROJECT}_mazawallets" ] ; then   
   echo "`date` mazawallets not running. Starting..." && docker run -d -v /home/wallets --name="${PROJECT}_mazawallets" ${WALLET}
fi
echo "`date` Starting ${PROJECT}_daemon"
mb=`docker ps -a|awk '{print $NF}' |grep ${PROJECT}_daemon|awk -F\, '{print $1}'`
if [ "${mb}" != "${PROJECT}_daemon" ] ; then   
   echo "`date` ${PROJECT}_daemon  not running. Starting..." && docker run -d -p ${P2P_OUTSIDE}:${P2P_INSIDE}  --name=${PROJECT}_daemon --volumes-from=${PROJECT}_mazablocks --volumes-from=${PROJECT}_mazawallets ${DAEMON}
fi
if [ "${mb}" != "${PROJECT}_mazawatch-ldb" ] ; then   
   echo "`date` mazablocks not running. Starting..." && docker run -d -v /home/mazachain --name="${PROJECT}_mazawatch-ldb" ${LDB}
fi

docker run -d -e "PROJECT=${PROJECT}" --name=${PROJECT}_mazawatch -p ${NGINX_OUTSIDE}:${NGINX_INSIDE}  -p ${MW_OUTSIDE}:${MW_INSIDE} --volumes-from=${PROJECT}_mazawatch-ldb --volumes-from=${PROJECT}_mazablocks --link ${PROJECT}_daemon:${PROJECT}_daemon ${EXPLORER}
