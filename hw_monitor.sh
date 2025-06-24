#!/bin/bash

# تاریخ و زمان جاری
DATE=$(date)

# دمای CPU
RAW_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMP=$(echo "scale=1; $RAW_TEMP / 1000" | bc)

# میانگین بار پردازنده در 1، 5 و 15 دقیقه اخیر
LOAD1=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
LOAD5=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f2 | xargs)
LOAD15=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f3 | xargs)

# وضعیت حافظه RAM
MEM=$(free -m | awk '/Mem:/ { printf "Used: %sMB / Total: %sMB / Free: %sMB", $3, $2, $4 }')

# بدنه ایمیل
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

# ارسال ایمیل
echo "$BODY" | mailx -s "📊 System Report from $(hostname)" seyedmohsenhoseyni82@gmail.com

