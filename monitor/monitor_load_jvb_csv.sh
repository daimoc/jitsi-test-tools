#!/bin/sh
dev="enp0s8"

read rx <"/sys/class/net/$dev/statistics/rx_bytes"
read tx <"/sys/class/net/$dev/statistics/tx_bytes"

echo "TIME;CPU_JVB;endpoints;rx,tx"

while :
do
timestamp=$newtimestamp
tsNano=`date +"%s%N"`
newtimestamp=$(( tsNano/1000 ))
#newtimestamp=$(date +%s.%N)

read newrx <"/sys/class/net/$dev/statistics/rx_bytes"
read newtx <"/sys/class/net/$dev/statistics/tx_bytes"

top -b -n1 -o PID > tmp_cpu.txt
echo -n `date +'%Y-%m-%d %H:%M:%S'`
echo -n ";"
grep jvb tmp_cpu.txt |awk '{printf $9";"}'
echo -n `curl -s -XGET http://127.0.0.1:8080/metrics | jq '.endpoints'`
echo -n ";"
grep -q "^$dev:" /proc/net/dev || exec echo "$dev: no such device"
delta=$((newtimestamp - timestamp))
# convert bytes to kbit/s: bytes * 8 / 1000 => bytes / 125
echo -n "$(( ((newrx-rx) * 8 * 1000 ) / delta  ));$(( ( (newtx-tx) * 8 *1000 ) / delta ))"
rx=$newrx
tx=$newtx

sleep 1
echo ""
done