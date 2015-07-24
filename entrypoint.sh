#!/bin/bash

PKPATH="/usr/lib/ioquake3/baseq3/pak0.pk3"
CFGPATH="/usr/lib/ioquake3/baseq3/server.cfg"

# Test for the existence of the pak0.pk3 file
if [ ! -f $PKPATH ]; then
    echo "!!! Pak0.pk3 is missing !!!"
    echo "Please bind mount pak0.pk3 to the root of the container."
    exit 1
fi

if [ ! -f $CFGPATH ]; then
    echo "!!! server.cfg is missing !!!"
    echo "Please bind mount server.cfg to the root of the container."
    exit 1
fi

case $1 in
server)
    /usr/lib/ioquake3/ioq3ded "${@:2}"
    ;;
*)
    /usr/lib/ioquake3/ioquake3 "$@"
    ;;
esac
