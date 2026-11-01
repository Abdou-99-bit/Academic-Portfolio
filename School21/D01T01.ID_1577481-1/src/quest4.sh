#!/bin/bash

echo "Checking if ai_door_control.sh is running..."
ps aux | grep ai_door_control | grep -v grep

echo
echo "Stopping ai_door_control.sh if it is running..."

for pid in $(ps aux | grep ai_door_control | grep -v grep | awk '{print $2}'); do
    echo "Killing PID $pid"
    kill -9 $pid
done

echo
echo "Done. Any running ai_door_control.sh processes should now be terminated."
