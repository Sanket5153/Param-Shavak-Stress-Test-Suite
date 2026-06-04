#!/bin/bash

DURATION_HOURS=24
END_TIME=$(( $(date +%s) + DURATION_HOURS*3600 ))

# Create directories
mkdir -p LOGS/HPL_LOG

COUNT=0

while [ $(date +%s) -lt $END_TIME ]
do
    COUNT=$((COUNT+1))

    LOGFILE="LOGS/HPL_LOG/run_${COUNT}.log"

    echo "Run $COUNT Started : $(date)" | tee -a LOGS/HPL_LOG/summary.log

    mpirun -np 48 xhpl HPL.dat 2>&1 | tee -a "$LOGFILE"
    #mpirun -np 48 xhpl HPL.dat > "$LOGFILE" 2>&1
    STATUS=$?

    echo "Run $COUNT Finished : $(date) Status=$STATUS" \
         | tee -a LOGS/HPL_LOG/summary.log

done
