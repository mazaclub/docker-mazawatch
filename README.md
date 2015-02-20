docker-mazawatch
================

## Deprecated see [mazaclub/mazachain-mazacoind](https://github.com/docker-mazachain-mazacoind)

Builds a docker with mazawatch ready to run in 
testnet or livenet modes

## Quick start

Just run the included run-mazawatch.sh


## Installation

As simple as git clone & make!!
<code>
git clone https://github.com/mazaclub/docker-mazawatch
cd docker-mazawatch
make all
<code>

## RUN







## Additional configuration

To use the include insecure SSH key, 
This comes with an ssh server running to simplify you manangement. You can either enter with nsenter, or ssh

Run the docker with ssh available:
<code> docker run (some startup config)  /sbin/my_init --enable-insecure-key<code>


<code>
# Download the insecure private key
curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
chmod 600 insecure_key

# Login to the container
ssh -i insecure_key root@localhost

# Running a command inside the container
ssh -i insecure_key root@<IP address> echo hello world
<code>

## CONFIGURATION



