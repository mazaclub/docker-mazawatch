#!/bin/bash
source /mazachain/env
source /mazachain.env
# allow variables to be set from systemd/env files/docker env 
test -z $MAZACOIND && MAZACOIND=$(cat /mazachain/env |grep ${PROJECT^^}_DAEMON | grep ${RPCPORT}| grep TCP_ADDR | awk -F\= '{print $2}')

MAZADIR=/home/maza/.mazacoin
TESTNETDIR=${MAZADIR}/testnet3
NETWORK=testnet
RPCPORT=11832
RPCUSER=$(grep rpcuser ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}')
RPCPASSWORD=$(grep rpcpassword ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}')
TESTNET=$(grep testnet ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}')
PROJECT=$(grep PROJECT /mazachain/env |tr '[a-z]' '[A-Z]'|awk -F\= '{print $2}')

if [ "${TESTNET}X" = "X" ] ; then
   NETWORK=livenet
   RPCPORT=$(grep rpcport ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}')
fi

echo "$(date) starting mazawatch with RPC from: ${MAZACOIND}:${RPCPORT}"
echo "BITCOIND_HOST= ${MAZACOIND} BITCOIN_DATADIR=${MAZADIR} BITCOIND_USER= ${RPCUSER} INSIGHT_NETWORK= ${NETWORK}"
BITCOIND_HOST=${MAZACOIND} BITCOIN_DATADIR="${MAZADIR}" BITCOIND_USER=${RPCUSER} BITCOIND_PASS=${RPCPASSWORD}  INSIGHT_NETWORK=${NETWORK} npm start

