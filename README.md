# jitsi-test-tools
Some basic tools to help deploy and quickly test Jitsi-Meet server 

## Jitsi-deploy directory

Bash script to install jitsi-meet
Usage 
> install_jitsi.sh [server_name]

## Monitor directory

Bash script to record cpu activity and networks of the Jitsi process

Require net-tools in Ubunut 22

apt install net-tools

## gst-meet-test

Some scripts to generate Jitsi-Meet load test with gst-Meet.
It only work with xmmp colibri and ws-colibri configured on Jitsi servers.

You need docker to run it.
