#!/bin/bash

mkdir -p LOGS/MONITOR_LOG

LOGFILE="LOGS/MONITOR_LOG/node_health.csv"

echo "Timestamp,Temp_C,Avg_CPU_MHz" > "$LOGFILE"

while true
do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    TEMP=$(sensors 2>/dev/null | grep "Package id 0" | head -1 | awk '{gsub(/[+°C]/,"",$4); print $4}')

    FREQ=$(awk -F: '/cpu MHz/ {sum+=$2; n++} END {printf "%.0f", sum/n}' /proc/cpuinfo)

    echo "$TIMESTAMP,$TEMP,$FREQ" >> "$LOGFILE"

    sleep 60
done
