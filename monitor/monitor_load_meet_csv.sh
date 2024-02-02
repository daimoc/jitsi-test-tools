#!/bin/sh
network="enp0s8"

read rx <"/sys/class/net/$network/statistics/rx_bytes"
read tx <"/sys/class/net/$network/statistics/tx_bytes"

echo "TIME;CPU_Prosody;CPU_NGINX_MASTER;CPU_NGINX_WORKER_1;CPU_NGINX_WORKER_2;CPU_NGINX_WORKER_3;CPU_NGINX_WORKER_4;CPU_JICOFO;SOCKET_NGINX;SOCKET_LUA;rx,tx"


while :
do

timestamp=$newtimestamp
tsNano=`date +"%s%N"`
newtimestamp=$(( tsNano/1000 ))
#newtimestamp=$(date +%s.%N)

read newrx <"/sys/class/net/$network/statistics/rx_bytes"
read newtx <"/sys/class/net/$network/statistics/tx_bytes"

top -b -n1 -o PID > tmp_cpu.txt
echo -n `date +'%Y-%m-%d %H:%M:%S'`
echo -n ";"
grep lua tmp_cpu.txt |awk '{printf $9";"}'
grep nginx tmp_cpu.txt|grep root |awk '{printf $9";"}'
grep nginx tmp_cpu.txt|grep www-data |awk '{printf $9";"}'
grep jicofo tmp_cpu.txt |awk '{printf $9";"}'
echo -n `sudo netstat -putan |grep nginx |wc -l`
echo -n ";"
echo -n `sudo netstat -putan |grep lua |wc -l`
echo -n ";"

delta=$((newtimestamp - timestamp))
# convert bytes to kbit/s: bytes * 8 / 1000 => bytes / 125
echo -n "$(( ((newrx-rx) * 8 * 1000 ) / delta  ));$(( ( (newtx-tx) * 8 *1000 ) / delta ))"
rx=$newrx
tx=$newtx

sleep 1
echo ""
done
