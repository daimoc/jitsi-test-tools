#!/bin/sh
# USAGE multi.sh [jitsi server] [nb_user_per_room] [test_simple.sh] [roomName]

MEET=$1
NB=$2
SCRIPT=$3
ROOM=$4

for i in `seq 1 $NB`
do
sh $SCRIPT $MEET $ROOM r2d2 &
echo $i
sleep 1
done