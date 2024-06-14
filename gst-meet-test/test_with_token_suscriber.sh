#!/bin/sh
# USAGE test_simple.sh meet.jit.si roomname nickname jwt_token


MEET=$1
ROOM=$2
NICK=$3
TOKEN=$4

IMAGE=daimoc/gst-meet:0.0.2

docker run --mount type=bind,source="$(pwd)"/media,target=/media  $IMAGE --video-codec=vp8 --nick $NICK --room-name $ROOM --last-n=10 --web-socket-url wss://$MEET/xmpp-websocket?room=$ROOM\&token=$TOKEN --xmpp-domain=$MEET --verbose=0 --recv-pipeline-participant-template="queue max-size-time=1000 name=audio ! fakeaudiosink queue max-size-time=1000 name=video ! fakevideosink"