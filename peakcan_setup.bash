#!/bin/bash
sudo ip link set $1 down
sudo ip link set $1 type can bitrate 250000
# sudo ip link set $1 type can bitrate 500000
sudo ip link set $1 name $1
sudo ip link set $1 up
sudo ifconfig $1 txqueuelen 100000
