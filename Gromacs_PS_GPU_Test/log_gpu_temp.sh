#!/bin/bash

# Directory to store logs
LOG_DIR="gpu_logs"
mkdir -p "$LOG_DIR"

# Create a new log file for each run
LOG_FILE="$LOG_DIR/gpu_temperature_$(date +%Y%m%d_%H%M%S).txt"

INTERVAL=10  # seconds

echo "GPU Temperature Logging Started: $(date)" > "$LOG_FILE"
echo "Logging to: $LOG_FILE"

while true
do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    nvidia-smi --query-gpu=index,name,temperature.gpu \
               --format=csv,noheader,nounits | \
    while IFS=',' read -r GPU_ID GPU_NAME TEMP
    do
        echo "$TIMESTAMP | GPU $GPU_ID | $GPU_NAME | ${TEMP}°C" >> "$LOG_FILE"
    done

    sleep "$INTERVAL"
done
