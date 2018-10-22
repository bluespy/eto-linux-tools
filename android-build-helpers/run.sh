#/bin/sh

SOURCE=$(pwd)/src
CCACHE=$(pwd)/ccache

mkdir -p $SOURCE
mkdir -p $CCACHE

sudo docker container stop /kernel-builder
sudo docker container rm /kernel-builder
sudo docker run -d -v $SOURCE:/usr/src -v $CCACHE:/ccache  --name kernel-builder bluespy/aicp-builder
sudo docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it kernel-builder bash
