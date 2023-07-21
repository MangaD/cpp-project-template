#!/bin/sh

set -eu

apt-get update

apt-get dist-upgrade -y

apt-get install --no-install-recommends -y \
	cmake \
	doxygen \
	graphviz \
	make

apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
