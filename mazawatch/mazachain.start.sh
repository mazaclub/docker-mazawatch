#!/bin/bash


MAZADIR=/home/maza/.mazacoin
TESTNETDIR=${MAZADIR}/testnet3
NETWORK=testnet
RPCPORT=11832
RPCUSER=`grep rpcuser ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}'`
RPCPASSWORD=`grep rpcpassword ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}'`
TESTNET=`grep testnet ${MAZADIR}/mazacoin.conf |awk -F\= '{print $2}'`
PROJECT=`grep PROJECT /mazachain/env |tr '[a-z]' '[A-Z]'|awk -F\= '{print $2}'`

if [ "${TESTNET}X" = "X" ] ; then
   NETWORK=livenet
   RPCPORT=12832
fi
MAZACOIND=`cat /mazachain/env |grep ${PROJECT^^}_DAEMON | grep ${RPCPORT}| grep TCP_ADDR | awk -F\= '{print $2}'`
echo "`date` starting mazawatch with RPC from: ${MAZACOIND}:${RPCPORT}"
echo "BITCOIND_HOST= ${MAZACOIND} BITCOIN_DATADIR= "${MAZADIR}" BITCOIND_USER= ${RPCUSER} BITCOIND_PASS= ${RPCPASSWORD}  INSIGHT_NETWORK= ${NETWORK} npm start"
BITCOIND_HOST=${MAZACOIND} BITCOIN_DATADIR="${MAZADIR}" BITCOIND_USER=${RPCUSER} BITCOIND_PASS=${RPCPASSWORD}  INSIGHT_NETWORK=${NETWORK} npm start

