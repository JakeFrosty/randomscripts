#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "Please run this as root"
	exit 1
fi

if [ $# -eq 0 ]; then
        echo "No caching server provided"
        echo "Usage: install-proxy-script.sh <caching server with port>"
        echo
        echo "Example: install-proxy-script.sh http://apt-cacher-ng.local:3142"
fi

echo  "Acquire::http::Proxy \"$1\";" > /etc/apt/apt.conf.d/00aptproxy

echo "script finished"