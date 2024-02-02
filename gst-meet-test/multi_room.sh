#!/bin/sh
# USAGE multi.sh [jitsi server] [nb_user_per_room] [nb_room] [test_simple.sh] [roomName]
MEET=$1
USER_PER_ROOM=$2
NB_ROOM=$3
SCRIPT=$4
ROOM=$5


for j in `seq 1 $NB_ROOM`
do
    for i in `seq 1 $USER_PER_ROOM`
    do
        ROOM_TMP=$ROOM$j
        sh $SCRIPT $MEET $ROOM_TMP BB8 >> null 2>&1 &
        echo $i
        sleep 3
    done
    echo $j
    sleep 3
done