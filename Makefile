USER=mazaclub
PROJECT=testnet

all:
	cd mazawatch &&  docker build -t ${USER}/mazawatch .
	cd mazawatch-ldb && docker build -t ${USER}/${PROJECT}-mazawatch-ldb .
	if [ ${PROJECT} = "testnet" ] ; then sh run-mazawatch.sh -testnet ; else sh run-mazawatch.sh ; fi
build:
	cd mazawatch &&  docker build -t ${USER}/mazawatch .

data:
	cd mazawatch-ldb && docker build -t ${USER}/${PROJECT}-mazawatch-ldb .
.PHONY: all
