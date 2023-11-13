#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run this as root"
    exit 1
fi

display_help() {
    echo "Please use the usage example below"
    echo "sudo sh install-docker.sh /path/to/docker/data/root"
}

if [ $# -eq 0 ]; then
    display_help
    exit 1
fi

data_root=$1
echo "Docker data root set to $data_root"

# install docker
curl -fsSL https://get.docker.com | bash

# add user to docker group
sudo usermod -aG docker $USER

# add template for docker daemon data-root
# make directory if it doesn't exist yet
mkdir -p /etc/docker
echo "{\n  "data-root": "${data_root}"\n}" > /etc/docker/daemon.json