#!/bin/sh

set -eu

apk update

apk upgrade --available

apk add --no-cache cmake \
	cmake \
	doxygen \
	graphviz \
	make

rm -rf /var/cache/apk/*