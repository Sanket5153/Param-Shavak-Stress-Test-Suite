#!/bin/bash

mkdir -p LOGS/MONITOR_LOG

LOGFILE="LOGS/MONITOR_LOG/node_health.csv"

echo "Timestamp,Temp_C,Avg_CPU_MHz" > "$LOGFILE"

echo "Monitoring started..."
echo "Logging to: $LOGFILE"
echo

while true
do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    TEMP=$(sensors 2>/dev/null | grep "Package id 0" | head -1 | awk '{gsub(/[+°C]/,"",$4); print $4}')

    FREQ=$(awk -F: '/cpu MHz/ {sum+=$2; n++} END {printf "%.0f", sum/n}' /proc/cpuinfo)

    LINE="$TIMESTAMP,$TEMP,$FREQ"

    # Write to CSV log
    echo "$LINE" >> "$LOGFILE"

    # Print to terminal
    echo "[$TIMESTAMP] Temp: ${TEMP}°C | Avg CPU Frequency: ${FREQ} MHz"

    sleep 30
done
