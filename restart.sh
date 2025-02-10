#!/bin/bash

CHECK_INTERVAL=10800  # Waktu cek dalam detik (default: 3 jam)
LOG_FILE="gaianet_monitor.log"

while true; do
    echo "Checking gaianet status..." | tee -a $LOG_FILE
    if ! pgrep -x "gaianet" > /dev/null; then
        echo "$(date): gaianet not running. Restarting..." | tee -a $LOG_FILE
        gaianet stop
        sleep 2
        gaianet start
        echo "$(date): gaianet restarted." | tee -a $LOG_FILE
    else
        echo "$(date): gaianet is running." | tee -a $LOG_FILE
    fi
    
    echo "$(date): Sleeping for $CHECK_INTERVAL seconds..." | tee -a $LOG_FILE
    for ((i=CHECK_INTERVAL; i>0; i--)); do
        echo -ne "$(date): Remaining sleep time: $i seconds...\r" | tee -a $LOG_FILE
        sleep 1
    done
    echo ""
done
