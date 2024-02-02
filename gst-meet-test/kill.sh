#!/bin/sh

sudo docker container kill `sudo docker ps |grep "gst-meet"|awk '{print $1}'`

echo "rm"
sudo docker container rm `sudo docker container ls -a |grep "gst-meet"|awk '{print $1}'`
