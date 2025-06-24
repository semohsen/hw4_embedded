#!/bin/bash

DATE=$(date)
RAW_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMP=$(echo "scale=1; $RAW_TEMP / 1000" | bc)

LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
MEM=$(free -m | awk '/Mem:/ { printf "Used: %sMB / Total: %sMB (Free: %sMB)", $3, $2, $4 }')

echo -e "📅 $DATE\n\n🌡️ CPU Temp: ${TEMP}°C\n📊 Load Average: $LOAD\n🧠 RAM: $MEM" | mailx -s "📋 System Report: $(hostname)" seyedmohsenhoseyni82@gmail.com
