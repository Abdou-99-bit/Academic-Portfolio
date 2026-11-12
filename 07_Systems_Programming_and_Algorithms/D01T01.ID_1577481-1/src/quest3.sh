#!/bin/bash

mkdir -p door_management_files/door_configuration
mkdir -p door_management_files/door_map
mkdir -p door_management_files/door_logs

echo "door1=open" > door_management_files/door_configuration/door1.conf
echo "door2=closed" > door_management_files/door_configuration/door2.conf
chmod 644 door_management_files/door_configuration/*.conf

echo "map data placeholder" > door_management_files/door_map/door_map_1.1
chmod 644 door_management_files/door_map/door_map_1.1

echo "door log example" > door_management_files/door_logs/door1.log
chmod 644 door_management_files/door_logs/*.log

for i in {3..10}; do echo "door$i=open" > door_management_files/door_configuration/door$i.conf; done
for i in {2..23}; do echo "log entry $i" > door_management_files/door_logs/door$i.log; done
chmod 644 door_management_files/door_configuration/*.conf
chmod 644 door_management_files/door_logs/*.log
