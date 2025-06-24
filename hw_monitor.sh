#!/bin/bash

DATE=$(date)

RAW_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMP=$(echo "scale=1; $RAW_TEMP / 1000" | bc)

LOAD1=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
LOAD5=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f2 | xargs)
LOAD15=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f3 | xargs)

MEM=$(free -m | awk '/Mem:/ { printf "Used: %sMB / Total: %sMB / Free: %sMB", $3, $2, $4 }')

BODY=$(cat <<EOF
📅 Date: $DATE

🌡️ CPU Temperature: ${TEMP}°C

🧠 CPU Load Average:
 - 1 minute:  $LOAD1
 - 5 minutes: $LOAD5
 - 15 minutes: $LOAD15

💾 RAM Usage:
 $MEM
EOF
)

echo "$BODY" | mailx -s "📊 System Report from $(hostname)" seyedmohsenhoseyni82@gmail.com

