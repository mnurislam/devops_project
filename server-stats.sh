#!/bin/bash

#todo
#Total CPU usage
#Total memory usage (Free vs Used including percentage)
#Total disk usage (Free vs Used including percentage)
#Top 5 processes by CPU usage
#Top 5 processes by memory usage

#variables
mem_usage=$(awk '$3=="kB"{$2=$2/1024^2;$3="GB";} 1' /proc/meminfo | grep 'MemTotal' | awk '{print $2,$3}')
mem_free=$(awk '$3=="kB"{$2=$2/1024^2;$3="GB";} 1' /proc/meminfo | grep 'MemFree' | awk '{print $2,$3}')

echo "*****************************************************************************"
echo "CPU Usage"
echo "*****************************************************************************"
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
echo
echo "*****************************************************************************"
echo "Memory Usage"
echo "*****************************************************************************"
echo "Total Memory Usage: $mem_usage"
echo "Total Free Memory: $mem_free"
echo
echo "*****************************************************************************"
echo "disk usage"
echo "*****************************************************************************"
df -h --total | awk '/total/ {printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'
echo
echo "*****************************************************************************"
echo "top 5 process by CPU usage"
echo "*****************************************************************************"
ps aux | sort -nrk 3,3 | head -n 5
echo
echo "*****************************************************************************"
echo "top 5 process by Mem usage"
echo "*****************************************************************************"
ps -eo pmem,pcpu,vsize,pid,cmd | sort -k 1 -nr | head -5