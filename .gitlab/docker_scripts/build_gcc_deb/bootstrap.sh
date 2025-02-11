#!/bin/sh

set -eu

apt-get update

apt-get dist-upgrade -y

apt-get install --no-install-recommends -y \
	build-essential \
	cmake \
	ninja-build \
	libwxgtk3.2-dev \
	libgtest-dev	

apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
