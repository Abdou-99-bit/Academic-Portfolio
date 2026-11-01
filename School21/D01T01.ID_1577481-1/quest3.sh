#!/bin/bash
mkdir -p src/door_management
echo "door=closed" > src/door_management/door.conf
chmod 644 src/door_management/door.conf

mkdir -p src/door_management/door_management_files
echo "door1=open" > src/door_management/door_management_files/door1.conf
echo "door2=closed" > src/door_management/door_management_files/door2.conf
chmod 644 src/door_management/door_management_files/*.conf
