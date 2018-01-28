#!/bin/bash

# This script is called by the main script (log.sh) by using "watch -n1" command
# This scripts writes system metrics to the log file in CSV format 

# Delimiter (tab) + disabling new line
SUP='\c'

FILENAME=$1
DELIM=$2

# Date and Time
echo -e "$(date '+%Y-%m-%d %H:%M:%S')$SUP" | tee -a $FILENAME 

# CPU (system) memory usage --- Parsing `free` command
echo -e " $(free -m | grep Mem: | sed 's/Mem://g' | sed "s/ \+ /$DELIM/g")$DELIM$SUP" | tee -a $FILENAME

# Swap
echo -e " $(IFS=' '; read -a strarr <<< $(free -m | grep Swap:); echo ${strarr[2]})$DELIM$SUP" | tee -a $FILENAME

# GPU memory usage
echo -e " $(echo "$(cat /proc/meminfo | grep NvMapMemUsed | sed 's/[^0-9]//g') / 1024" | bc)$DELIM$SUP" | tee -a $FILENAME

# CPU frequency
echo -e " $(($(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)/1000))$DELIM$SUP" | tee -a $FILENAME

# CPU utilization

# GPU frequency
echo -e " $(($(cat /sys/devices/platform/host1x/57000000.gpu/devfreq/57000000.gpu/cur_freq)/1000000))$DELIM$SUP" | tee -a $FILENAME

# GPU utilization
echo -e " $(cat /sys/devices/platform/host1x/57000000.gpu/load)$DELIM$SUP" | tee -a $FILENAME

# CPU temperature
echo -e " $(echo "scale=1; $(cat /sys/devices/virtual/thermal/thermal_zone1/temp)/1000" | bc)$DELIM$SUP" | tee -a $FILENAME

# GPU temperature
echo -e " $(echo "scale=1; $(cat /sys/devices/virtual/thermal/thermal_zone2/temp)/1000" | bc) " | tee -a $FILENAME

