#!/bin/bash
sudo ip link set $1 down
sudo ip link set $1 type can bitrate $2
sudo ip link set $1 name $1
sudo ip link set $1 up
sudo ifconfig $1 txqueuelen 100000
