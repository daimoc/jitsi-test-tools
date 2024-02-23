#!/bin/sh
# USAGE test_simple.sh meet.jit.si roomname nickname

MEET=$1
ROOM=$2
NICK=$3

IMAGE=gst-meet

docker run --mount type=bind,source="$(pwd)"/media,target=/media  $IMAGE --video-codec=vp8 --nick $NICK --room-name $ROOM --last-n=0 --web-socket-url wss://$MEET/xmpp-websocket?room=$ROOM --xmpp-domain=$MEET --verbose --send-pipeline="filesrc location=/media/bbb.webm ! queue max-size-time=200000 ! matroskademux name=demuxer  demuxer.video_0 ! queue max-size-time=10000 name=video demuxer.audio_0 ! queue max-size-time=10000 name=audio" --recv-pipeline-participant-template="queue max-size-time=1000 name=audio ! fakeaudiosink queue max-size-time=1000 name=video ! fakevideosink"
