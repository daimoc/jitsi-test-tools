#!/bin/sh
# USAGE test_simple.sh meet.jit.si roomname nickname jwt_token


MEET=$1
ROOM=$2
NICK=$3
TOKEN=$4

IMAGE=daimoc/gst-meet:0.0.2

docker run --mount type=bind,source="$(pwd)"/media,target=/media  $IMAGE --nick $NICK --room-name $ROOM --last-n=1 --web-socket-url wss://$MEET/xmpp-websocket?room=$ROOM\&token=$TOKEN \
--xmpp-domain=$MEET --verbose=0 \
--send-pipeline="filesrc location=/media/sample3.mp3 !  queue ! decodebin ! audioconvert ! audioresample ! opusenc name=audio "
