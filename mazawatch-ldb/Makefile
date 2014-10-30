USER=mazaclub
LDB=mazawatch-ldb
data:
	cp mazacoin.conf-livenet mazacoin.conf
	docker build -t ${USER}/${LDB} .

testnet:
	cp mazacoin.conf-testnet mazacoin.conf
	docker build -t ${USER}/testnet-${LDB} .
.PHONY: data
